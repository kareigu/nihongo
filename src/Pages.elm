module Pages exposing (katakana, hiragana, kanji, numbers, combined)

import Html exposing (h1, div, text, button)
import Html.Attributes exposing (class)

import Shared exposing (Msg(..), Model)


katakana : Model -> Html.Html Msg
katakana model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      glyph_showcase model "カ",
      choices_container model
    ]



hiragana : Model -> Html.Html Msg
hiragana _ =
  div [ class "flex flex-col p-4" ]
    [ 
      h1 [] [ text "hiragana" ]
    ]


kanji : Model -> Html.Html Msg
kanji _ =
  div [ class "flex flex-col p-4" ]
    [ 
      h1 [] [ text "kanji" ]
    ]


numbers : Model -> Html.Html Msg
numbers _ =
  div [ class "flex flex-col p-4" ]
    [ 
      h1 [] [ text "numbers" ]
    ]

combined : Model -> Html.Html Msg
combined model =
  div [ class "flex flex-col p-4" ]
    [ 
      hiragana model,
      katakana model,
      kanji model,
      numbers model
    ]


glyph_showcase : Model -> String -> Html.Html Msg
glyph_showcase _ glyph =
  div [ class "text-center bg-platinum text-auburn w-28 h-28 m-4 rounded-sm drop-shadow-md" ]
    [ h1 [ class "select-none font-Kosugi h-full w-full flex justify-center items-center text-5xl" ] [ text glyph ] ]

choices_container : Model -> Html.Html Msg
choices_container model =
  div [ class "flex flex-row" ]
    [
      choice_button model "ga",
      choice_button model "zu",
      choice_button model "shi",
      choice_button model "ka"
    ]

choice_button : Model -> String -> Html.Html Msg
choice_button _ choice =
  div [ class "text-center bg-platinum text-auburn w-14 h-14 m-4 rounded-sm drop-shadow-md" ]
    [ button [ class "select-none font-PT-Sans h-full w-full flex justify-center items-center text-2xl" ] [ text choice ] ]
