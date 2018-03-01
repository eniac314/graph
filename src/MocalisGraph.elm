port module MocalisGraph exposing (..)

import Graph exposing (..)
import Graph.GraphViz as GraphViz exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes as Attr exposing (..)
import SvgParser exposing (parse)

mainFiles = 
    [ Node 1  { text = "Main" , attrs = mainStyle }

    , Node 2  { text = "MultLangText" , attrs = helperStyle }
    , Node 9  { text = "Utils" , attrs = helperStyle }
    , Node 10 { text = "Combox" , attrs = helperStyle }

    , Node 3  { text = "UserAccounts" , attrs = userAccountsStyle }
    , Node 5  { text = "UserAccountsTypes" , attrs = userAccountsStyle }
    , Node 6  { text = "Login" , attrs = userAccountsStyle }
    , Node 7  { text = "Signup" , attrs = userAccountsStyle }
    , Node 8  { text = "UsrManager" , attrs = userAccountsStyle }
    
    , Node 4  { text = "Rosette" , attrs = mainStyle }
    , Node 11 { text = "Filesys" , attrs = helperStyle }
    , Node 12 { text = "FileSysEdit" , attrs = mainStyle }
    , Node 13 { text = "Dropzone" , attrs = mainStyle }
    , Node 14 { text = "SearchEngine" , attrs = mainStyle }
    , Node 15 { text = "MetadataEdit" , attrs = mainStyle }
    
    , Node 16 { text = "BlogEntry" , attrs = blogStyle }
    , Node 17 { text = "BetterParser" , attrs = blogStyle }
    , Node 18 { text = "Tokenizer" , attrs = blogStyle }
    , Node 19 { text = "Parser" , attrs = blogStyle }
    

    
    ]

mainImports = 
    [ Edge 2  1  { attrs = ""}
    , Edge 3  1  { attrs = ""}
    , Edge 4  1  { attrs = ""}

    , Edge 5  3  { attrs = ""}
    , Edge 6  3  { attrs = ""}
    , Edge 7  3  { attrs = ""}
    , Edge 8  3  { attrs = ""}
    , Edge 9  3  { attrs = ""}

    , Edge 11 4  { attrs = ""}
    , Edge 12 4  { attrs = ""}
    , Edge 13 4  { attrs = ""}
    , Edge 14 4  { attrs = ""}
    , Edge 3  4  { attrs = ""}
    , Edge 9  4  { attrs = ""}
    , Edge 5  4  { attrs = ""}
    , Edge 16 4  { attrs = ""}


    , Edge 2  5  { attrs = ""}

    , Edge 2  6  { attrs = ""}
    , Edge 5  6  { attrs = ""}
    , Edge 9  6  { attrs = ""}

    , Edge 2  7  { attrs = ""}
    , Edge 5  7  { attrs = ""}
    , Edge 9  7  { attrs = ""}

    , Edge 2  8  { attrs = ""}
    , Edge 5  8  { attrs = ""}
    , Edge 9  8  { attrs = ""}
    , Edge 10 8  { attrs = ""}

    , Edge 2  9  { attrs = ""}

    , Edge 9  11 { attrs = ""}
    , Edge 5  11 { attrs = ""}

    , Edge 9  12 { attrs = ""}
    , Edge 3  12 { attrs = ""}
    , Edge 10 12 { attrs = ""}
    , Edge 11 12 { attrs = ""}
    , Edge 15 12 { attrs = ""}

    , Edge 9  13 { attrs = ""}
    , Edge 10 13 { attrs = ""}
    , Edge 3  13 { attrs = ""}

    , Edge 11 14 { attrs = ""}
    , Edge 9  14 { attrs = ""}

    , Edge 11 15 { attrs = ""}
    , Edge 10 15 { attrs = ""}
    , Edge 9  15 { attrs = ""}
    , Edge 3  15 { attrs = ""}

    , Edge 17 16 { attrs = ""}
    , Edge 18 16 { attrs = ""}
    , Edge 19 16 { attrs = ""}
    , Edge 11 16 { attrs = ""}
    , Edge 10 16 { attrs = ""}
    , Edge 9  16 { attrs = ""}
    , Edge 3  16 { attrs = ""}

    , Edge 18 17 { attrs = ""}

    , Edge 17 19 { attrs = ""}
    , Edge 18 19 { attrs = ""}
    , Edge 9  19 { attrs = ""}


    ]

mainGraph =
    fromNodesAndEdges mainFiles mainImports
                     
topStylesBT =
    { defaultStyles
        | rankdir = BT
        , node = "shape = box, colorscheme = brbg4"
    }

topStylesTB =
    { defaultStyles
        | rankdir = TB
        , node = "shape = box, colorscheme = accent5"
        --, graph = "ranksep = 4"
    }

mainStyle =
    "color = 1, style = filled"

userAccountsStyle = 
    "color = 2, style = filled"

helperStyle = 
    "color = 3, style = filled"

blogStyle = 
    "color = 4, style = filled"

mainGraphStr = GraphViz.outputWithStylesWithOverrides topStylesBT mainGraph

-------------------------------------------------------------------------------
comsNodes = 
    elmComsFiles ++
    phpFiles ++
    sqlTables ++ 
    folders ++ 
    htmlFiles

elmComsFiles = 
    [ Node 36 { text = "BlogEntry", attrs = elmComsFilesStyle }
    , Node 37 { text = "Dropzone", attrs = elmComsFilesStyle }
    , Node 39 { text = "FileSysEdit", attrs = elmComsFilesStyle }
    , Node 40 { text = "Login", attrs = elmComsFilesStyle }
    , Node 41 { text = "Rosette", attrs = elmComsFilesStyle }
    , Node 42 { text = "Parser", attrs = elmComsFilesStyle }
    , Node 43 { text = "Signup", attrs = elmComsFilesStyle }
    , Node 44 { text = "UsrManager", attrs = elmComsFilesStyle }

    ]

phpFiles =
    [ Node 1  { text = "filesPermUpload" , attrs = phpFileStyle }
    , Node 2  { text = "filesUpload" , attrs = phpFileStyle }
    , Node 3  { text = "getArticles" , attrs = phpFileStyle }
    , Node 4  { text = "getContentRaw" , attrs = phpFileStyle }
    , Node 5  { text = "getContentTok" , attrs = phpFileStyle }
    , Node 6  { text = "getFiles" , attrs = phpFileStyle }
    , Node 7  { text = "getPictures" , attrs = phpFileStyle }
    , Node 8  { text = "getusers" , attrs = phpFileStyle }
    , Node 9  { text = "getUUID" , attrs = phpFileStyle }
    , Node 10 { text = "login" , attrs = phpFileStyle }
    , Node 11 { text = "logout" , attrs = phpFileStyle }
    , Node 12 { text = "manageusers" , attrs = phpFileStyle }
    , Node 13 { text = "picsPermUpload" , attrs = phpFileStyle }
    , Node 14 { text = "picsUpload" , attrs = phpFileStyle }
    , Node 15 { text = "removeFiles" , attrs = phpFileStyle }
    , Node 16 { text = "removePics" , attrs = phpFileStyle }
    , Node 17 { text = "saveContent" , attrs = phpFileStyle }
    , Node 18 { text = "setBookmark" , attrs = phpFileStyle }
    , Node 19 { text = "showFile" , attrs = phpFileStyle }
    , Node 20 { text = "showPic" , attrs = phpFileStyle }
    , Node 21 { text = "signup" , attrs = phpFileStyle }
    --, Node 22 { text = "test" , attrs = phpFileStyle }
    , Node 23 { text = "updateFileSys" , attrs = phpFileStyle }
    --, Node 24 { text = "utils" , attrs = phpFileStyle }
    ]

sqlTables = 
    [ Node 25  { text = "articles" , attrs = sqlTableStyle }
    , Node 26  { text = "articlesKeywords" , attrs = sqlTableStyle }
    , Node 27  { text = "articlesTopics" , attrs = sqlTableStyle }
    , Node 28  { text = "bookmarks" , attrs = sqlTableStyle }
    , Node 29  { text = "files" , attrs = sqlTableStyle }
    , Node 30  { text = "pictures" , attrs = sqlTableStyle }
    , Node 31  { text = "users" , attrs = sqlTableStyle }
    ]    

folders = 
    [ Node 32 { text = "content/raw", attrs = foldersStyle }
    , Node 33 { text = "content/tokens", attrs = foldersStyle }
    , Node 34 { text = "content/pictures", attrs = foldersStyle }
    , Node 35 { text = "content/files", attrs = foldersStyle }

    ]

htmlFiles = 
    [ Node 38 { text = "index.html", attrs = htmlStyle }]

communications = 
    [ Edge 31 1  selectComStyle
    , Edge 1  29 updateComStyle
    
    , Edge 31 2  selectComStyle
    , Edge 2  29 insertComStyle
    , Edge 2  35 fileInteractStyle
    
    , Edge 31 3  selectComStyle
    , Edge 25 3  selectComStyle
    , Edge 28 3  selectComStyle
    , Edge 26 3  selectComStyle
    , Edge 27 3  selectComStyle
    
    , Edge 31 4  selectComStyle
    , Edge 25 4  selectComStyle
    , Edge 32 4  fileInteractStyle

    , Edge 31 5  selectComStyle
    , Edge 25 5  selectComStyle
    , Edge 33 5  fileInteractStyle

    , Edge 31 6  selectComStyle
    , Edge 29 6  selectComStyle

    , Edge 31 7  selectComStyle
    , Edge 30 7  selectComStyle

    , Edge 31 8  selectComStyle

    , Edge 31 10 selectComStyle

    , Edge 31 12 selectComStyle
    , Edge 12 31 delUpComStyle

    , Edge 31 13 selectComStyle
    , Edge 13 30 updateComStyle

    , Edge 31 14 selectComStyle
    , Edge 14 34  fileInteractStyle
    , Edge 14 30 insertComStyle

    , Edge 31 15 selectComStyle
    , Edge 15 29 deleteComStyle
    , Edge 15 35 fileInteractStyle

    , Edge 31 16 selectComStyle
    , Edge 16 30 deleteComStyle
    , Edge 16 34 fileInteractStyle

    , Edge 31 17 selectComStyle
    , Edge 17 32 fileInteractStyle
    , Edge 17 33 fileInteractStyle
    
    , Edge 31 18 selectComStyle
    , Edge 18 28 updateComStyle

    , Edge 31 19 selectComStyle
    , Edge 29 19 selectComStyle
    , Edge 35 19 fileInteractStyle

    , Edge 31 20 selectComStyle
    , Edge 30 20 selectComStyle
    , Edge 34 20 fileInteractStyle

    , Edge 31 21 selectComStyle
    , Edge 21 31 insertComStyle

    , Edge 31 23 selectComStyle
    , Edge 23 25 insUpDelComStyle
    , Edge 23 26 insDelComStyle
    , Edge 23 27 insDelComStyle
    
    , Edge 36 17 postComStyle
    , Edge 4  36 postComStyle
    , Edge 5  36 postComStyle
    , Edge 36 38 portComsStyle
    
    , Edge 6 37  postComStyle
    , Edge 7 37  postComStyle
    , Edge 37 16 postComStyle
    , Edge 37 15 postComStyle
    , Edge 37 13 postComStyle
    , Edge 37 1  postComStyle
    , Edge 37 38 portComsStyle

    , Edge 38 2  postComStyle
    , Edge 38 14 postComStyle
    

    , Edge 9  39 getComStyle
    , Edge 39 23 postComStyle

    , Edge 10 40 getComStyle
    , Edge 40 11 postComStyle 
    
    , Edge 3  41 postComStyle
    , Edge 41 18 postComStyle 

    , Edge 19 42 getComStyle
    , Edge 20 42 getComStyle
    
    , Edge 43 21 postComStyle
    
    , Edge 8  44 getComStyle
    , Edge 44 12 postComStyle
    ]

elmComsFilesStyle =
    "fillcolor = 1, style = filled, shape = octagon"

phpFileStyle =
    "fillcolor = 2, style = filled"

sqlTableStyle =
    "fillcolor = 3, style = filled, shape = cylinder"

foldersStyle = 
    "fillcolor = 4, style = filled, shape = folder"

htmlStyle = 
    "fillcolor = 5, style = filled, shape = house"


getComStyle = 
    { attrs = "color = pink"}

postComStyle = 
    { attrs = "color = blue"}

updateComStyle =
    { attrs = "color = green"}

selectComStyle =
    { attrs = "color = purple"}

insertComStyle = 
    { attrs = "color = orange"}

deleteComStyle = 
    { attrs = "color = deeppink4"}

insDelComStyle = 
    { attrs = "color = \"deeppink4:invis:orange\", arrowsize = 1.5"}

delUpComStyle = 
    { attrs = "color = \"deeppink4:invis:green\", arrowsize = 1.5"}

insUpDelComStyle = 
    { attrs = "color = \"orange:invis:green:invis:deeppink4\", arrowsize = 2"}


fileInteractStyle = 
    { attrs = "color = crimson"}    

portComsStyle = 
    { attrs = "color = tomato"}

comsGraph = fromNodesAndEdges comsNodes communications

comsGraphStr = GraphViz.outputWithStylesWithOverrides topStylesTB comsGraph
               |> \s -> addSubgraphs s []

-------------------------------------------------------------------------------

port toRender : String -> Cmd msg

port svgStrSub : (String -> msg ) -> Sub msg

type alias Model = 
    { graphVizStr : List String 
    , svgStr : List String
    }

type Msg = SvgStr String
         | Parse

main = Html.program { init = init
                    , update = update 
                    , view = view
                    , subscriptions = subscriptions
                    }

init = 
    let graphs =
         [ mainGraphStr
         , comsGraphStr
         ] 
    
    in 
    { graphVizStr = graphs
    , svgStr = []
    } ! List.map toRender graphs

update msg model = 
    case msg of 
        SvgStr s -> { model | svgStr = trimXml s :: model.svgStr } ! []

        Parse -> model ! List.map toRender model.graphVizStr

view model = 
    div [] 
    [
     --button [onClick Parse] [Html.text "parse graph"]
     --, 
    List.map parse model.svgStr
        |> List.foldr (\v acc -> 
                        case v of 
                          Err _ -> acc
                          Ok svg -> svg :: acc) []
        --|> List.intersperse (div [] [ br [] [], hr [] [], br [] [] ])
        |> div [Attr.classList [("scale",True)]]
    ] 

    --div [] (List.map (\gStr -> pre [] [text gStr]) model.graphVizStr)



subscriptions model = Sub.batch [svgStrSub SvgStr]

trimXml s = 
    case String.indexes "<svg " s of 
      [] -> s 
      (n::xs) -> String.dropLeft n s



addSubgraphs : String -> List (List (Graph.Node { attrs : String, text : String })) -> String
addSubgraphs s xs = 
  let makeSubGraph n xs = 
       "  subgraph cluster_" ++ Basics.toString n ++ " {\n" ++
       "  rank = same" ++ Basics.toString n ++ "; " ++ 
       ( List.map (\node -> node.label.text ++ "; ") xs
         |> String.join ""
       ) ++ "\n  }\n\n" 
  
  in "\n" ++ (String.dropRight 2 s) ++ "\n" ++
     ( Tuple.first 
         <| List.foldr (\gs (res,n) -> (makeSubGraph n gs ++ res, n + 1))
            ("",0)
            xs
     ) ++ "\n}\n"

--https://github.com/mdaines/viz.js/
--http://www.graphviz.org/documentation/