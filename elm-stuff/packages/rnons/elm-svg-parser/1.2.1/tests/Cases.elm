module Cases exposing (all)

import SvgParser exposing (..)


withVersionDoc : String
withVersionDoc =
    """
<?xml version="1.0" encoding="UTF-8" ?>
<svg width="24" height="24" viewBox="0 0 24 24">
</svg>
     """


withVersionElement : Element
withVersionElement =
    Element "svg"
        [ ( "width", "24" )
        , ( "height", "24" )
        , ( "viewBox", "0 0 24 24" )
        ]
        []


motorcycleIcon : String
motorcycleIcon =
    """
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24" height="24" viewBox="0 0 24 24">
    <defs>
        <path id="a" d="M0 0h24v24H0z"/>
    </defs>
    <clipPath id="b">
        <use xlink:href="#a" overflow="visible"/>
    </clipPath>
    <path clip-path="url(#b)" d="M19.44 9.03L15.41 5H11v2h3.59l2 2H5c-2.8 0-5 2.2-5 5s2.2 5 5 5c2.46 0 4.45-1.69 4.9-4h1.65l2.77-2.77c-.21.54-.32 1.14-.32 1.77 0 2.8 2.2 5 5 5s5-2.2 5-5c0-2.65-1.97-4.77-4.56-4.97zM7.82 15C7.4 16.15 6.28 17 5 17c-1.63 0-3-1.37-3-3s1.37-3 3-3c1.28 0 2.4.85 2.82 2H5v2h2.82zM19 17c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3z"/>
</svg>
    """


motorcycleElement : Element
motorcycleElement =
    Element "svg"
        [ ( "xmlns", "http://www.w3.org/2000/svg" )
        , ( "xmlns:xlink", "http://www.w3.org/1999/xlink" )
        , ( "width", "24" )
        , ( "height", "24" )
        , ( "viewBox", "0 0 24 24" )
        ]
        [ SvgElement <|
            Element "defs"
                []
                [ SvgElement <|
                    Element "path"
                        [ ( "id", "a" )
                        , ( "d", "M0 0h24v24H0z" )
                        ]
                        []
                ]
        , SvgElement <|
            Element "clipPath"
                [ ( "id", "b" ) ]
                [ SvgElement <|
                    Element "use"
                        [ ( "xlink:href", "#a" )
                        , ( "overflow", "visible" )
                        ]
                        []
                ]
        , SvgElement <|
            Element "path"
                [ ( "clip-path", "url(#b)" )
                , ( "d", "M19.44 9.03L15.41 5H11v2h3.59l2 2H5c-2.8 0-5 2.2-5 5s2.2 5 5 5c2.46 0 4.45-1.69 4.9-4h1.65l2.77-2.77c-.21.54-.32 1.14-.32 1.77 0 2.8 2.2 5 5 5s5-2.2 5-5c0-2.65-1.97-4.77-4.56-4.97zM7.82 15C7.4 16.15 6.28 17 5 17c-1.63 0-3-1.37-3-3s1.37-3 3-3c1.28 0 2.4.85 2.82 2H5v2h2.82zM19 17c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3z" )
                ]
                []
        ]


all =
    [ ( "with version doc", withVersionDoc, withVersionElement )
    , ( "motocycle icon", motorcycleIcon, motorcycleElement )
    ]
