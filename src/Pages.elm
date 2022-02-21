module Pages exposing (katakana, hiragana, kanji, numbers, combined)

import Html exposing (h1, div, text, button)
import Html.Attributes exposing (class)

import Shared exposing (Msg(..), Model, katakana_glyphs, Glyph, ChoiceData)
import Random
import Array exposing (Array)


katakana : Model -> Html.Html Msg
katakana model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      picking_view model
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


picking_view : Model -> Html.Html Msg
picking_view model =
  div []
    [
      case model.choice_data.current of
        Nothing ->
          div [ class "flex flex-col items-center" ]
            [
              text "Nothing rolled"
            ]

        Just x ->
          div [ class "flex flex-col items-center" ]
            [
              glyph_showcase model (Tuple.first x.correct),
              choices_container model x.choices
            ]
    ]

glyph_showcase : Model -> String -> Html.Html Msg
glyph_showcase _ glyph =
  div [ class "text-center bg-platinum text-auburn w-28 h-28 m-4 rounded-sm drop-shadow-md" ]
    [ h1 [ class "select-none font-Kosugi h-full w-full flex justify-center items-center text-5xl" ] 
      [ text glyph ] 
    ]

choices_container : Model -> List Glyph -> Html.Html Msg
choices_container model choices =
  div [ class "flex flex-row" ]
    (List.map make_choice_button choices)

make_choice_button : Glyph -> Html.Html Msg
make_choice_button glyph =
  choice_button (Tuple.second glyph)

choice_button : String -> Html.Html Msg
choice_button choice =
  div [ class "text-center bg-platinum text-auburn w-14 h-14 m-4 rounded-sm drop-shadow-md" ]
    [ button [ class "select-none font-PT-Sans h-full w-full flex justify-center items-center text-2xl" ] [ text choice ] ]
