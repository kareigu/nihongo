module Pages exposing (katakana, hiragana, kanji, numbers, combined)

import Html exposing (h1, div, text, button)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)

import Shared exposing (Msg(..), Model, Glyph, Guess(..), Choices, Pages(..))


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
  let
    use_large_buttons =
      case model.selectedPage of
          Kanji -> True
          Numbers -> True
          _ -> False

  in
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
              choices_container model use_large_buttons x.choices,
              div 
                [ 
                  class """flex justify-center items-center mt-10 gap-8
                    w-[95%] p-4 bg-mountbatten-pink rounded-sm""" 
                ]
                [
                  move_button "✕" False (ChangePage Menu),
                  next_button model
                ]
            ]
    ]

next_button : Model -> Html.Html Msg
next_button model =
  ( 
    ( move_button "⫸" (model.choice_data.guess == NotGuessed) Reroll )
  )

move_button : String -> Bool -> Msg -> Html.Html Msg
move_button btn_text off msg =
  button 
  [ 
    class """bg-platinum text-auburn
      text-3xl flex justify-center 
      w-14 h-14
      items-center rounded-sm
      drop-shadow-md
      hover:outline hover:outline-mountbatten-pink 
      hover:text-raisin-black hover:outline-4
      hover:drop-shadow-lg
      active:outline active:outline-mountbatten-pink 
      active:text-raisin-black active:outline-4
      active:outline-offset-2 active:drop-shadow-xl
      disabled:grayscale
      transition-all""", 
    onClick msg,
    disabled off
  ] 
  [ text btn_text ]

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

choices_container : Model -> Bool -> Choices -> Html.Html Msg
choices_container model large choices =
  div 
    [ 
      class 
        ("w-screen sm:w-full " 
          ++ if large then 
              "grid grid-cols-2 justify-items-center" 
            else 
              "flex flex-row justify-center") 
    ]
    (List.map (make_choice_button model large) choices)

make_choice_button : Model -> Bool -> Glyph -> Html.Html Msg
make_choice_button model large glyph =
  choice_button glyph large model

choice_button : Glyph -> Bool -> Model -> Html.Html Msg
choice_button choice large model =
  let
    btn_text =
      Tuple.second choice

    text_size =
      if String.length btn_text > 8 then
        "text-lg"
      else
        "text-2xl"

  in
  div [ 
      class 
        (
          "text-center bg-platinum text-auburn h-14 m-4 rounded-sm drop-shadow-md "
          ++
          if large then "w-28" else "w-14"
        ),
      onClick (
        if model.choice_data.guess == NotGuessed then
          MakeGuess choice
        else
          NoOp
        ) 
    ]
    [ button 
      [ 
        class (
          "select-none font-PT-Sans h-full w-full flex justify-center items-center " 
          ++
          text_size
        )
      ] 
      [ text btn_text ] 
    ]
