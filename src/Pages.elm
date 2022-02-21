module Pages exposing (katakana, hiragana, kanji, numbers, combined)

import Html exposing (h1, div, text, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Shared exposing (Msg(..), Model, Glyph, Guess(..))


katakana : Model -> Html.Html Msg
katakana model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      picking_view model
    ]



hiragana : Model -> Html.Html Msg
hiragana model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      picking_view model
    ]


kanji : Model -> Html.Html Msg
kanji model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      picking_view model
    ]


numbers : Model -> Html.Html Msg
numbers model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      picking_view model
    ]

combined : Model -> Html.Html Msg
combined model =
  div [ class "flex flex-col items-center p-4" ]
    [ 
      picking_view model
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
glyph_showcase model glyph =
  let
    bg_colour = (case model.choice_data.guess of 
      NotGuessed ->
        "bg-platinum"
      Correct ->
        "bg-green-500"
      Wrong ->
        "bg-red-500")
  in
  div [ class ("text-center text-auburn w-28 h-28 m-4 rounded-sm drop-shadow-md " ++ bg_colour) ]
    [ h1 [ class "select-none font-Kosugi h-full w-full flex justify-center items-center text-5xl" ] 
      [ text glyph ] 
    ]

choices_container : Model -> List Glyph -> Html.Html Msg
choices_container model choices =
  div [ class "flex flex-row" ]
    (List.map (make_choice_button model) choices)

make_choice_button : Model -> Glyph -> Html.Html Msg
make_choice_button model glyph =
  choice_button glyph model

choice_button : Glyph -> Model -> Html.Html Msg
choice_button choice model =
  div [ 
      class "text-center bg-platinum text-auburn w-14 h-14 m-4 rounded-sm drop-shadow-md",
      onClick (
        if model.choice_data.guess == NotGuessed then
          MakeGuess choice
        else
          NoOp
        ) 
    ]
    [ button [ class "select-none font-PT-Sans h-full w-full flex justify-center items-center text-2xl" ] 
      [ text (Tuple.second choice) ] 
    ]
