module Pages exposing (katakana, hiragana, kanji, numbers, combined)

import Html exposing (h1, div, text)
import Html.Attributes exposing (class)

import Shared exposing (Msg(..), Model)


katakana : Model -> Html.Html Msg
katakana _ =
  div [ class "flex p-4" ]
    [ 
      h1 [] [ text "katakana"]
    ]



hiragana : Model -> Html.Html Msg
hiragana _ =
  div [ class "flex p-4" ]
    [ 
      h1 [] [ text "hiragana"]
    ]


kanji : Model -> Html.Html Msg
kanji _ =
  div [ class "flex p-4" ]
    [ 
      h1 [] [ text "kanji"]
    ]


numbers : Model -> Html.Html Msg
numbers _ =
  div [ class "flex p-4" ]
    [ 
      h1 [] [ text "numbers"]
    ]

combined : Model -> Html.Html Msg
combined model =
  div [ class "flex p-4" ]
    [ 
      hiragana model,
      katakana model,
      kanji model,
      numbers model
    ]