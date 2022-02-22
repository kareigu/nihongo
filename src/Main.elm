module Main exposing (..)

import Browser
import Html exposing (button, div, h1, text, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Shared exposing (Msg(..), Pages(..), Model, Guess(..))
import Pages
import MsgHandler
import Shared exposing (default_model)


main : Program () Model Msg
main =
  Browser.element 
    { 
      init = init, 
      view = view, 
      update = update,
      subscriptions = subscriptions
    }


init : () -> (Model, Cmd Msg)
init _ =
  (
    default_model,
    Cmd.none
  )

subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangePage page ->
      MsgHandler.change_page page model

    Reroll ->
      MsgHandler.reroll model

    RollChoices correct ->
      MsgHandler.roll_choices correct model

    UpdateChoices (rolls, correct) ->
      MsgHandler.update_choices (rolls, correct) model

    MakeGuess guess ->
      MsgHandler.make_guess guess model

    NoOp ->
      ( model, Cmd.none )


view : Model -> Html.Html Msg
view model =
  div [ class "flex flex-col h-[95vh] m-4 overflow-x-hidden" ]
    [ h1 [ class """text-center font-bold mt-3 text-4xl py-2 select-none 
                  text-auburn bg-platinum border-4 border-x-auburn 
                  border-t-platinum border-b-raisin-black
                  rounded font-PT-Sans""" ] 
        [ text "NIHONGO - 日本語" ],
      div [ class "flex flex-col mt-2 mb-2 h-full" ] 
        [ 
          app_view model
        ]
    ]


app_view : Model -> Html.Html Msg
app_view model = 
  div [class "flex flex-col items-center"]
    [
      case model.selectedPage of
        Menu -> main_menu model
        Hiragana -> Pages.hiragana model
        Katakana -> Pages.katakana model
        Kanji -> Pages.kanji model
        Numbers -> Pages.numbers model
        Combined -> Pages.combined model
    ]

main_menu_items : List Pages
main_menu_items =
  [
    Hiragana,
    Katakana,
    Kanji,
    Numbers
  ]

main_menu_button : Pages -> Html.Html Msg
main_menu_button page =
  button [ 
      class """group bg-platinum text-auburn w-32 h-32 m-4 
            outline outline-4 outline-cherry-pink rounded-sm drop-shadow-md 
            hover:outline-auburn hover:outline-offset-0 hover:text-raisin-black hover:drop-shadow-xl
            active:outline-auburn active:outline-offset-2 active:text-raisin-black active:drop-shadow-2xl
            transition-all duration-75""", 
      onClick (ChangePage page) 
    ] 
    [ 
      let (r, j) = button_inner page
      in
        div [ class "flex flex-col h-full justify-center last:flex-end"]
        [
          h1 [ class "font-Shippori h-full pt-10 text-4xl group-hover:drop-shadow-2xl"] [ text j ],
          p [ class "font-PT-Sans mb-1 group-hover:drop-shadow-2xl" ] [ text (String.toUpper r) ]
        ]
    ]

button_inner : Pages -> (String, String)
button_inner page =
  case page of  
    Hiragana -> ("Hiragana", "平仮名")
    Katakana -> ("Katakana", "片仮名")
    Kanji -> ("Kanji", "漢字")
    Numbers -> ("Numbers", "番号")
    Combined -> ("Combined", "混ぜる")
    _ -> ("", "")

main_menu : Model -> Html.Html Msg
main_menu _ =
  div [class "flex flex-col items-center"]
    [
      div [class "grid grid-cols-2"]
        ( List.map main_menu_button main_menu_items ),
      main_menu_button Combined
    ]
