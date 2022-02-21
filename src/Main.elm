module Main exposing (..)

import Browser
import Html exposing (button, div, h1, text, span, p)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Shared exposing (Msg(..), Pages(..), Model, katakana_glyphs, Glyph, GlyphList, CurrentChoice)
import Pages
import Random
import Array exposing (Array)


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
    {
    choice_data = {
      current = Nothing,
      bank = katakana_glyphs
    },
    selectedPage = Menu
    },
    Cmd.none
  )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ChangePage p ->
      let max_index = 3
      in
      (
        { model | 
          selectedPage = p,
          choice_data = { 
            current = Nothing,
            bank = page_to_bank p
          }
        }, 
        Random.generate RollChoices (Random.int 0 max_index)
      )

    RollChoices correct ->
      let
        max_index = 
          (Array.length model.choice_data.bank - 1)

      in
      (
        model,
        Random.generate UpdateChoices (Random.pair (Random.list 4 (Random.int 0 max_index)) (Random.constant correct))
      )

    UpdateChoices (rolls, correct) ->
      (
        { model |
          choice_data = {
            bank = model.choice_data.bank,
            current = Just
              {
                correct = (get_correct correct rolls model.choice_data.bank),
                choices = (rolls_to_choices rolls [] model.choice_data.bank)
              }
          }
        },
        Cmd.none
      )



page_to_bank : Pages -> GlyphList
page_to_bank page =
  case page of
    Katakana -> katakana_glyphs
    _ -> katakana_glyphs

rolls_to_choices : (List Int) -> (List Glyph) -> GlyphList -> (List Glyph)
rolls_to_choices rolls choices glyphs =
  case List.isEmpty rolls of
    False ->
      rolls_to_choices 
        (List.drop 1 rolls) 
        (
          case rolls of
            [] ->
              choices
            head :: rem ->
              choices ++ [(get_glyph_at_index head glyphs)]
        )
        glyphs
    True ->
      choices

get_correct : Int -> List Int -> GlyphList -> Glyph
get_correct correct rolls glyphs =
  case (Array.get correct (Array.fromList rolls)) of
    Just i ->
      get_glyph_at_index i glyphs
    Nothing ->
      ("E", "Error")

get_glyph_at_index : Int -> GlyphList -> Glyph
get_glyph_at_index index glyphs =
  Maybe.withDefault ("E", "Error") (Array.get index glyphs)


view : Model -> Html.Html Msg
view model =
  div [ class "flex flex-col h-screen m-4 overflow-x-hidden" ]
    [ h1 [ class """text-center font-bold mt-3 text-4xl py-2 select-none 
                  text-auburn bg-platinum border-4 border-x-auburn 
                  border-t-platinum border-b-raisin-black
                  rounded font-PT-Sans""" ] 
        [ text "NIHONGO - 日本語" ],
      div [ class "flex flex-col mt-2 mb-2 h-full" ] 
        [ 
          app_view model,
          if model.selectedPage == Menu then 
            span [ class "w-0 h-0" ] []
          else
            button [ class "btn mx-4 mt-auto mb-10", onClick (ChangePage Menu) ] [ text "Menu" ]
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
