port module GitesGraph exposing (..)

--import Svg exposing (..)

import Dict exposing (..)
import Graph exposing (..)
import Graph.GraphViz as GraphViz exposing (..)
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (onClick)
import SvgParser exposing (parse, parseToNode)


nodes =
    [ Node 1 { text = "Main", attrs = mainStyle }
    , Node 2 { text = "Types", attrs = mainStyle }
    , Node 3 { text = "MultLangText", attrs = mainStyle }
    , Node 4 { text = "Booking.Booking", attrs = bookingStyle }
    , Node 7 { text = "Booking.Types", attrs = bookingStyle }
    , Node 8 { text = "Booking.BookingComs", attrs = bookingStyle }
    , Node 9 { text = "Booking.BookingView", attrs = bookingStyle }
    , Node 10 { text = "Booking.Utils", attrs = bookingStyle }
    , Node 11 { text = "Booking.MultLangText", attrs = bookingStyle }
    , Node 13 { text = "Booking.StyleSheet", attrs = bookingStyle }
    , Node 5 { text = "BookingAdmin.BookingAdmin", attrs = bookingAdminStyle }
    , Node 14 { text = "BookingAdmin.BookingAdminComs", attrs = bookingAdminStyle }
    , Node 15 { text = "BookingAdmin.BookingAdminView", attrs = bookingAdminStyle }
    , Node 16 { text = "BookingAdmin.StyleSheet", attrs = bookingAdminStyle }
    , Node 17 { text = "BookingAdmin.Types", attrs = bookingAdminStyle }
    , Node 6 { text = "UserAccounts.UserAccounts", attrs = userAccountsStyle }
    , Node 18 { text = "UserAccounts.UserAccountsTypes", attrs = userAccountsStyle }
    , Node 19 { text = "UserAccounts.MultLangText", attrs = userAccountsStyle }
    , Node 20 { text = "UserAccounts.Login", attrs = userAccountsStyle }
    , Node 21 { text = "UserAccounts.Signup", attrs = userAccountsStyle }
    , Node 22 { text = "UserAccounts.UsrManager", attrs = userAccountsStyle }
    , Node 23 { text = "UserAccounts.ComBox", attrs = userAccountsStyle }
    , Node 24 { text = "UserAccounts.Utils", attrs = userAccountsStyle }
    , Node 25 { text = "GiteGallery.GiteGallery", attrs = giteGalleryStyle }
    , Node 26 { text = "GiteGallery.GiteGalleryData", attrs = giteGalleryStyle }
    , Node 27 { text = "GiteGallery.GiteGalleryView", attrs = giteGalleryStyle }
    , Node 28 { text = "GiteGallery.MultLangText", attrs = giteGalleryStyle }
    , Node 29 { text = "GiteGallery.Streams", attrs = giteGalleryStyle }
    , Node 30 { text = "GiteGallery.StyleSheet", attrs = giteGalleryStyle }
    , Node 31 { text = "GiteGallery.Types", attrs = giteGalleryStyle }
    , Node 12 { text = "DatePicker", attrs = datePickerStyle }
    ]


imports =
    [ Edge 2 1 { attrs = "" }
    , Edge 3 1 { attrs = "" }
    , Edge 4 1 { attrs = "" }
    , Edge 5 1 { attrs = "" }
    , Edge 6 1 { attrs = "" }
    , Edge 25 1 { attrs = "" }
    , Edge 3 2 { attrs = "" }
    , Edge 4 2 { attrs = "" }
    , Edge 5 2 { attrs = "" }
    , Edge 6 2 { attrs = "" }
    , Edge 25 2 { attrs = "" }
    , Edge 6 3 { attrs = "" }
    , Edge 4 3 { attrs = "" }
    , Edge 25 3 { attrs = "" }
    , Edge 7 4 { attrs = "" }
    , Edge 8 4 { attrs = "" }
    , Edge 9 4 { attrs = "" }
    , Edge 10 4 { attrs = "" }
    , Edge 11 4 { attrs = "" }
    , Edge 12 4 { attrs = "" }
    , Edge 12 5 { attrs = "" }
    , Edge 11 5 { attrs = "" }
    , Edge 17 5 { attrs = "" }
    , Edge 14 5 { attrs = "" }
    , Edge 6 5 { attrs = "" }
    , Edge 15 5 { attrs = "" }
    , Edge 18 6 { attrs = "" }
    , Edge 19 6 { attrs = "" }
    , Edge 20 6 { attrs = "" }
    , Edge 21 6 { attrs = "" }
    , Edge 22 6 { attrs = "" }
    , Edge 24 6 { attrs = "" }
    , Edge 11 7 { attrs = "" }
    , Edge 12 7 { attrs = "" }
    , Edge 7 8 { attrs = "" }
    , Edge 11 8 { attrs = "" }
    , Edge 10 8 { attrs = "" }
    , Edge 13 9 { attrs = "" }
    , Edge 7 9 { attrs = "" }
    , Edge 10 9 { attrs = "" }
    , Edge 11 9 { attrs = "" }
    , Edge 12 9 { attrs = "" }
    , Edge 7 10 { attrs = "" }
    , Edge 12 10 { attrs = "" }
    , Edge 13 11 { attrs = "" }
    , Edge 17 14 { attrs = "" }
    , Edge 6 14 { attrs = "" }
    , Edge 12 14 { attrs = "" }
    , Edge 11 14 { attrs = "" }
    , Edge 16 15 { attrs = "" }
    , Edge 17 15 { attrs = "" }
    , Edge 11 15 { attrs = "" }
    , Edge 12 15 { attrs = "" }
    , Edge 12 17 { attrs = "" }
    , Edge 11 17 { attrs = "" }
    , Edge 19 18 { attrs = "" }
    , Edge 18 20 { attrs = "" }
    , Edge 19 20 { attrs = "" }
    , Edge 24 20 { attrs = "" }
    , Edge 18 21 { attrs = "" }
    , Edge 19 21 { attrs = "" }
    , Edge 24 21 { attrs = "" }
    , Edge 18 22 { attrs = "" }
    , Edge 19 22 { attrs = "" }
    , Edge 23 22 { attrs = "" }
    , Edge 24 22 { attrs = "" }
    , Edge 19 24 { attrs = "" }
    , Edge 31 25 { attrs = "" }
    , Edge 27 25 { attrs = "" }
    , Edge 29 25 { attrs = "" }
    , Edge 28 25 { attrs = "" }
    , Edge 26 25 { attrs = "" }
    , Edge 31 26 { attrs = "" }
    , Edge 28 26 { attrs = "" }
    , Edge 29 26 { attrs = "" }
    , Edge 30 26 { attrs = "" }
    , Edge 31 27 { attrs = "" }
    , Edge 30 27 { attrs = "" }
    , Edge 28 27 { attrs = "" }
    , Edge 29 27 { attrs = "" }
    , Edge 29 31 { attrs = "" }
    , Edge 30 31 { attrs = "" }
    , Edge 28 31 { attrs = "" }
    ]


graph =
    fromNodesAndEdges nodes imports


topStyles =
    { defaultStyles
        | rankdir = BT
        , node = "shape = box, colorscheme = puor6"
    }


mainStyle =
    "fillcolor = 1, style = filled"


bookingStyle =
    "fillcolor = 2, style = filled"


bookingAdminStyle =
    "fillcolor = 3, style = filled"


userAccountsStyle =
    "fillcolor = 4, style = filled"


datePickerStyle =
    "fillcolor = 5, style = filled"


giteGalleryStyle =
    "fillcolor = 6, style = filled"


mainEdgeStyle =
    defaultStyles


importsGraphStr =
    GraphViz.outputWithStylesWithOverrides topStyles graph
        |> (\s -> addSubgraphs s [])



-------------------------------------------------------------------------------


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
        [ "Booking.Booking"
        , "BookingAdmin.BookingAdmin"
        , "UserAccounts.UserAccounts"
        ]


phpFiles =
    List.map PhpNode
        [ "getBookings"
        , "getBookingsAdmin"
        , "login"
        , "logout"
        , "processUpdates"
        , "saveBooking"
        ]


sqlTables =
    List.map SqlTableNode
        [ "bookings"
        , "dateKind"
        , "users"
        ]


htmlFiles =
    List.map HtmlNode
        [ "index.html"
        ]


comNodes =
    elmFiles
        ++ phpFiles
        ++ sqlTables
        ++ htmlFiles


comEdges =
    [ ( "getBookings", "Booking.Booking", [ GetEdge ] )
    , ( "Booking.Booking", "saveBooking", [ PostEdge ] )
    , ( "Booking.Booking", "index.html", [ Port ] )
    , ( "getBookingsAdmin", "BookingAdmin.BookingAdmin", [ GetEdge ] )
    , ( "BookingAdmin.BookingAdmin", "processUpdates", [ PostEdge ] )
    , ( "UserAccounts.UserAccounts", "login", [ PostEdge ] )
    , ( "login", "UserAccounts.UserAccounts", [ GetEdge ] )
    , ( "UserAccounts.UserAccounts", "logout", [ PostEdge ] )
    , ( "users", "login", [ SelectEdge ] )
    , ( "dateKind", "getBookings", [ SelectEdge ] )
    , ( "users", "getBookingsAdmin", [ SelectEdge ] )
    , ( "dateKind", "getBookingsAdmin", [ SelectEdge ] )
    , ( "bookings", "getBookingsAdmin", [ SelectEdge ] )
    , ( "users", "processUpdates", [ SelectEdge ] )
    , ( "processUpdates", "dateKind", [ UpdateEdge, InsertEdge, Delete ] )
    , ( "processUpdates", "bookings", [ UpdateEdge, InsertEdge, Delete ] )
    , ( "saveBooking", "bookings", [ InsertEdge ] )
    , ( "saveBooking", "dateKind", [ InsertEdge ] )
    ]


extractStr : ComNode -> String
extractStr cn =
    case cn of
        PhpNode s ->
            s

        ElmNode s ->
            s

        SqlTableNode s ->
            s

        HtmlNode s ->
            s

        FolderNode s ->
            s


comGraphStr =
    makeComGraph comNodes comEdges


makeComGraph nodesData edgesData =
    let
        index =
            List.map extractStr nodesData
                |> List.foldr (\node ( i, res ) -> ( i + 1, ( node, i ) :: res )) ( 0, [] )
                |> Tuple.second
                |> Dict.fromList

        makeNode node n =
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

        edgeColor e =
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
            List.map makeEdge edgesData
                |> removeNothings

        graph =
            fromNodesAndEdges nodes edges
    in
    GraphViz.outputWithStylesWithOverrides topStylesTB graph
        |> (\s -> addSubgraphs s [])


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
            [ importsGraphStr
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


removeNothings xs =
    List.foldr
        (\x acc ->
            case x of
                Nothing ->
                    acc

                Just x_ ->
                    x_ :: acc
        )
        []
        xs



--https://github.com/mdaines/viz.js/
--http://www.graphviz.org/documentation/
