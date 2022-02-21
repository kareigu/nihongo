module Main exposing (..)

import Browser
import Html exposing (button, div, h1, text, span, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Dict exposing (Dict)

import Counter exposing (counter, update_counter)
import Shared exposing (Msg(..), Pages(..), Model)
import Pages


main : Program () Model Msg
main =
  Browser.sandbox 
    { 
      init = init, 
      view = view, 
      update = update 
    }




init : Model
init =
  {
    count = 0,
    selectedPage = Menu
  }




update : Msg -> Model -> Model
update msg model =
  case msg of
    UpdateCounter c -> 
      { model | count = update_counter c model.count }
    ChangePage p ->
      { model | selectedPage = p }



view : Model -> Html.Html Msg
view model =
  div [ class "grid m-4" ]
    [ h1 [ class "text-center font-bold text-4xl text-auburn font-PT-Sans" ] 
        [ text "NIHONGO - 日本語" ],
      div [ class "flex flex-col justify-center last:mt-auto last:mb-2" ] 
        [ 
          app_view model,
          if model.selectedPage == Menu then 
            span [] []
          else
            button [ class "btn m-4", onClick (ChangePage Menu) ] [ text "Menu" ]
        ]
    ]

app_view : Model -> Html.Html Msg
app_view model = 
  div [class "flex flex-col justify-center items-center"]
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
    class "group bg-platinum text-auburn w-32 h-32 m-4 rounded-sm drop-shadow-md hover:text-raisin-black hover:drop-shadow-2xl", 
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
  div [class "flex flex-col justify-center items-center mt-5"]
    [
      div [class "grid grid-cols-2"]
        ( List.map main_menu_button main_menu_items ),
      main_menu_button Combined
    ]
