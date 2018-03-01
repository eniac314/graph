port module UminokirinGraph exposing (..)

--import Svg exposing (..)

import Dict exposing (..)
import Graph exposing (..)
import Graph.GraphViz as GraphViz exposing (..)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onClick)
import SvgParser exposing (parse, parseToNode)


-------------------------------------------------------------------------------
-- Imports graph


type ImportNode
    = Main String
    | Writing String
    | Kana String
    | Kanji String
    | UserAccounts String


type ImportEdge
    = ImportEdge


mainFiles =
    List.map Main
        [ "Main"
        , "Types"
        ]


writingFiles =
    List.map Writing
        [ "Writing"
        , "WritingContent"
        ]


kanaFiles =
    List.map Kana
        [ "PracticeContent"
        , "Practice"
        , "LessonsContent"
        , "Lessons"
        , "Kana"
        , "KanaVirtKeyb"
        ]


kanjiFiles =
    List.map Kanji
        [ "Kanji"
        , "KanjiFormView"
        , "KanjiComs"
        , "KanjiTypes"
        , "KanjiFormTypes"
        , "KanjiTypesCommon"
        , "KanjiInput"
        , "KanjiInputComs"
        , "Utils"
        ]


usrAccntsFiles =
    List.map UserAccounts
        [ "UserAccounts.Utils"
        , "UserAccounts.UsrManager"
        , "UserAccounts.UserAccountsTypes"
        , "UserAccounts.UserAccounts"
        , "UserAccounts.Signup"
        , "UserAccounts.MultLangText"
        , "UserAccounts.Login"
        , "UserAccounts.ComBox"
        ]


importNodes =
    mainFiles
        ++ writingFiles
        ++ kanaFiles
        ++ kanjiFiles
        ++ usrAccntsFiles


importEdges =
    [ ( "Writing", "Main", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "Main", [ ImportEdge ] )
    , ( "UserAccounts.MultLangText", "Main", [ ImportEdge ] )
    , ( "Types", "Main", [ ImportEdge ] )
    , ( "WritingContent", "Practice", [ ImportEdge ] )
    , ( "KanaVirtKeyb", "Practice", [ ImportEdge ] )
    , ( "PracticeContent", "Practice", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "Types", [ ImportEdge ] )
    , ( "Writing", "Types", [ ImportEdge ] )
    , ( "UserAccounts.ComBox", "Utils", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "Utils", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "Writing", [ ImportEdge ] )
    , ( "WritingContent", "Writing", [ ImportEdge ] )
    , ( "Kana", "Writing", [ ImportEdge ] )
    , ( "Kanji", "Writing", [ ImportEdge ] )
    , ( "Lessons", "Kana", [ ImportEdge ] )
    , ( "KanjiComs", "Kanji", [ ImportEdge ] )
    , ( "KanjiInput", "Kanji", [ ImportEdge ] )
    , ( "KanjiTypes", "Kanji", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "Kanji", [ ImportEdge ] )
    , ( "Utils", "Kanji", [ ImportEdge ] )
    , ( "KanjiTypes", "KanjiComs", [ ImportEdge ] )
    , ( "KanjiTypesCommon", "KanjiComs", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "KanjiComs", [ ImportEdge ] )
    , ( "KanjiTypesCommon", "KanjiFormTypes", [ ImportEdge ] )
    , ( "UserAccounts.ComBox", "KanjiFormTypes", [ ImportEdge ] )
    , ( "KanjiFormTypes", "KanjiFormView", [ ImportEdge ] )
    , ( "UserAccounts.ComBox", "KanjiFormView", [ ImportEdge ] )
    , ( "KanjiFormTypes", "KanjiInput", [ ImportEdge ] )
    , ( "KanjiFormView", "KanjiInput", [ ImportEdge ] )
    , ( "KanjiInputComs", "KanjiInput", [ ImportEdge ] )
    , ( "UserAccounts.ComBox", "KanjiInput", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "KanjiInput", [ ImportEdge ] )
    , ( "Utils", "KanjiInput", [ ImportEdge ] )
    , ( "UserAccounts.UserAccounts", "KanjiInputComs", [ ImportEdge ] )
    , ( "KanjiFormTypes", "KanjiInputComs", [ ImportEdge ] )
    , ( "KanjiTypesCommon", "KanjiInputComs", [ ImportEdge ] )
    , ( "Utils", "KanjiInputComs", [ ImportEdge ] )
    , ( "KanjiInput", "KanjiTypes", [ ImportEdge ] )
    , ( "KanjiTypesCommon", "KanjiTypes", [ ImportEdge ] )
    , ( "Utils", "KanjiTypesCommon", [ ImportEdge ] )
    , ( "UserAccounts.ComBox", "KanjiTypesCommon", [ ImportEdge ] )
    , ( "WritingContent", "Lessons", [ ImportEdge ] )
    , ( "Practice", "Lessons", [ ImportEdge ] )
    , ( "Practice", "LessonsContent", [ ImportEdge ] )
    , ( "UserAccounts.MultLangText", "UserAccounts.Login", [ ImportEdge ] )
    , ( "UserAccounts.UserAccountsTypes", "UserAccounts.Login", [ ImportEdge ] )
    , ( "UserAccounts.Utils", "UserAccounts.Login", [ ImportEdge ] )
    , ( "UserAccounts.MultLangText", "UserAccounts.Signup", [ ImportEdge ] )
    , ( "UserAccounts.UserAccountsTypes", "UserAccounts.Signup", [ ImportEdge ] )
    , ( "UserAccounts.Utils", "UserAccounts.Signup", [ ImportEdge ] )
    , ( "UserAccounts.MultLangText", "UserAccounts.UserAccounts", [ ImportEdge ] )
    , ( "UserAccounts.UserAccountsTypes", "UserAccounts.UserAccounts", [ ImportEdge ] )
    , ( "UserAccounts.Login", "UserAccounts.UserAccounts", [ ImportEdge ] )
    , ( "UserAccounts.Signup", "UserAccounts.UserAccounts", [ ImportEdge ] )
    , ( "UserAccounts.UsrManager", "UserAccounts.UserAccounts", [ ImportEdge ] )
    , ( "UserAccounts.Utils", "UserAccounts.UserAccounts", [ ImportEdge ] )
    , ( "UserAccounts.MultLangText", "UserAccounts.UserAccountsTypes", [ ImportEdge ] )
    , ( "UserAccounts.UserAccountsTypes", "UserAccounts.UsrManager", [ ImportEdge ] )
    , ( "UserAccounts.ComBox", "UserAccounts.UsrManager", [ ImportEdge ] )
    , ( "UserAccounts.UserAccountsTypes", "UserAccounts.UsrManager", [ ImportEdge ] )
    , ( "UserAccounts.Utils", "UserAccounts.UsrManager", [ ImportEdge ] )
    , ( "UserAccounts.MultLangText", "UserAccounts.Utils", [ ImportEdge ] )
    ]


makeImportNode node n =
    case node of
        Main s ->
            Node n { text = s, attrs = mainFileStyle }

        Writing s ->
            Node n { text = s, attrs = writingFileStyle }

        Kana s ->
            Node n { text = s, attrs = kanaFileStyle }

        Kanji s ->
            Node n { text = s, attrs = kanjiFileStyle }

        UserAccounts s ->
            Node n { text = s, attrs = usrAccntsFileStyle }


importEdgeColor e =
    "black"


topStylesBT =
    { defaultStyles
        | rankdir = BT
        , node = "shape = box, colorscheme = accent5"

        --, graph = "ranksep = 4"
    }


mainFileStyle =
    "fillcolor = 1, style = filled, shape = octagon"


writingFileStyle =
    "fillcolor = 2, style = filled"


kanaFileStyle =
    "fillcolor = 3, style = filled, shape = cylinder"


kanjiFileStyle =
    "fillcolor = 4, style = filled, shape = folder"


usrAccntsFileStyle =
    "fillcolor = 5, style = filled, shape = house"


importGraphStr =
    makeGraph importNodes importEdges makeImportNode importEdgeColor topStylesBT



-------------------------------------------------------------------------------
-- Com graph


type ComNode
    = PhpNode String
    | ElmNode String
    | SqlTableNode String
    | HtmlNode String
    | FolderNode String


type ComEdge
    = GetEdge
    | PostEdge
    | UpdateEdge
    | SelectEdge
    | InsertEdge
    | Delete
    | FileInteract
    | Port


elmFiles =
    List.map ElmNode
        [ "KanjiComs"
        , "KanjiInputComs"
        , "Main"
        , "UserAccounts.UserAccounts"
        ]


phpFiles =
    List.map PhpNode
        [ "deleteKanji"
        , "getEveryKanji"
        , "getKanji"
        , "getusers"
        , "login"
        , "logout"
        , "updateKanji"
        ]


sqlTables =
    List.map SqlTableNode
        [ "kanji"
        , "users"
        ]


htmlFiles =
    List.map HtmlNode
        [ "index.html" ]


comNodes =
    elmFiles
        ++ phpFiles
        ++ sqlTables
        ++ htmlFiles


comEdges =
    [ ( "getKanji", "KanjiComs", [ GetEdge ] )
    , ( "getEveryKanji", "KanjiComs", [ GetEdge ] )
    , ( "getKanji", "KanjiInputComs", [ GetEdge ] )
    , ( "KanjiInputComs", "updateKanji", [ PostEdge ] )
    , ( "KanjiInputComs", "deleteKanji", [ PostEdge ] )
    , ( "Main", "index.html", [ Port ] )
    , ( "users", "deleteKanji", [ SelectEdge ] )
    , ( "deleteKanji", "kanji", [ Delete ] )
    , ( "getEveryKanji", "kanji", [ SelectEdge ] )
    , ( "kanji", "getKanji", [ SelectEdge ] )
    , ( "users", "getusers", [ SelectEdge ] )
    , ( "UserAccounts.UserAccounts", "login", [ PostEdge ] )
    , ( "login", "UserAccounts.UserAccounts", [ GetEdge ] )
    , ( "UserAccounts.UserAccounts", "logout", [ PostEdge ] )
    , ( "users", "login", [ SelectEdge ] )
    , ( "users", "updateKanji", [ SelectEdge ] )
    , ( "updateKanji", "kanji", [ InsertEdge ] )
    ]


makeComNode node n =
    case node of
        PhpNode s ->
            Node n { text = s, attrs = phpFileStyle }

        ElmNode s ->
            Node n { text = s, attrs = elmComsFileStyle }

        SqlTableNode s ->
            Node n { text = s, attrs = sqlTableStyle }

        HtmlNode s ->
            Node n { text = s, attrs = htmlStyle }

        FolderNode s ->
            Node n { text = s, attrs = foldersStyle }


comEdgeColor e =
    case e of
        GetEdge ->
            "pink"

        PostEdge ->
            "blue"

        UpdateEdge ->
            "green"

        SelectEdge ->
            "purple"

        InsertEdge ->
            "orange"

        Delete ->
            "deeppink4"

        FileInteract ->
            "crimson"

        Port ->
            "tomato"


topStylesTB =
    { defaultStyles
        | rankdir = TB
        , node = "shape = box, colorscheme = accent5"

        --, graph = "ranksep = 4"
    }


elmComsFileStyle =
    "fillcolor = 1, style = filled, shape = octagon"


phpFileStyle =
    "fillcolor = 2, style = filled"


sqlTableStyle =
    "fillcolor = 3, style = filled, shape = cylinder"


foldersStyle =
    "fillcolor = 4, style = filled, shape = folder"


htmlStyle =
    "fillcolor = 5, style = filled, shape = house"


comGraphStr =
    makeGraph comNodes comEdges makeComNode comEdgeColor topStylesTB



-------------------------------------------------------------------------------


makeGraph nodesData edgesData makeNode edgeColor topStyle =
    let
        index =
            List.map (.label >> .text) nodes
                |> List.foldr (\node ( i, res ) -> ( i + 1, ( node, i ) :: res )) ( 0, [] )
                |> Tuple.second
                |> Dict.fromList

        edgeAttrs xs =
            case xs of
                e :: [] ->
                    { attrs = "color = " ++ edgeColor e }

                _ ->
                    List.map edgeColor xs
                        |> List.intersperse ":invis:"
                        |> (\cs -> "\"" ++ String.join "" cs ++ "\"")
                        |> (\cstr ->
                                { attrs =
                                    "color = "
                                        ++ cstr
                                        ++ ", arrowsize = "
                                        ++ (Basics.toString <|
                                                0.5
                                                    + 0.5
                                                    * (toFloat <| List.length xs)
                                           )
                                }
                           )

        makeEdge ( from, to, styles ) =
            case ( Dict.get from index, Dict.get to index ) of
                ( Just n1, Just n2 ) ->
                    Just <| Edge n1 n2 (edgeAttrs styles)

                _ ->
                    Nothing

        nodes =
            List.foldr (\n ( res, i ) -> ( makeNode n i :: res, i + 1 )) ( [], 0 ) nodesData
                |> Tuple.first

        edges =
            List.filterMap makeEdge edgesData

        graph =
            fromNodesAndEdges nodes edges
    in
        GraphViz.outputWithStylesWithOverrides topStyle graph
            |> (\s -> addSubgraphs s [])



-------------------------------------------------------------------------------


port toRender : String -> Cmd msg


port svgStrSub : (String -> msg) -> Sub msg


type alias Model =
    { graphVizStr : List String
    , svgStr : List String
    }


type Msg
    = SvgStr String
    | Parse


main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init =
    let
        graphs =
            [ importGraphStr
            , comGraphStr
            ]
    in
        { graphVizStr = graphs
        , svgStr = []
        }
            ! List.map toRender graphs


update msg model =
    case msg of
        SvgStr s ->
            { model | svgStr = trimXml s :: model.svgStr } ! []

        Parse ->
            model ! List.map toRender model.graphVizStr


view model =
    div []
        [ --button [onClick Parse] [Html.text "parse graph"]
          --,
          List.map parse model.svgStr
            |> List.foldr
                (\v acc ->
                    case v of
                        Err _ ->
                            acc

                        Ok svg ->
                            svg :: acc
                )
                []
            --|> List.intersperse (div [] [ br [] [], hr [] [], br [] [] ])
            |> div [ Attr.classList [ ( "scale", True ) ] ]

        --, text <| Basics.toString (List.map parseToNode model.svgStr)
        ]



--div [] (List.map (\gStr -> pre [] [text gStr]) model.graphVizStr)


subscriptions model =
    Sub.batch [ svgStrSub SvgStr ]


trimXml s =
    case String.indexes "<svg " s of
        [] ->
            s

        n :: xs ->
            String.dropLeft n s


addSubgraphs : String -> List (List (Graph.Node { attrs : String, text : String })) -> String
addSubgraphs s xs =
    let
        makeSubGraph n xs =
            "  subgraph cluster_"
                ++ Basics.toString n
                ++ " {\n"
                ++ "  rank = same"
                ++ Basics.toString n
                ++ "; "
                ++ (List.map (\node -> node.label.text ++ "; ") xs
                        |> String.join ""
                   )
                ++ "\n  }\n\n"
    in
        "\n"
            ++ String.dropRight 2 s
            ++ "\n"
            ++ (Tuple.first <|
                    List.foldr (\gs ( res, n ) -> ( makeSubGraph n gs ++ res, n + 1 ))
                        ( "", 0 )
                        xs
               )
            ++ "\n}\n"



--https://github.com/mdaines/viz.js/
--http://www.graphviz.org/documentation/
