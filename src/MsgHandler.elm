module MsgHandler exposing (..)

import Shared exposing (Msg(..), Pages(..), Model, Glyph, GlyphList, Guess(..))
import Random
import Glyphs
import Array

change_page :  Pages -> Model -> (Model, Cmd Msg)
change_page page model =
  (
    { model | 
      selectedPage = page,
      choice_data = { 
        current = Nothing,
        bank = page_to_bank page,
        guess = NotGuessed
      }
    }, 
    if page == Menu then
      Cmd.none
    else
      Random.generate RollChoices (Random.int 0 3)
  )

reroll : Model -> (Model, Cmd Msg)
reroll model =
  (
    model,
    Random.generate RollChoices (Random.int 0 3)
  )

roll_choices : Int -> Model -> (Model, Cmd Msg)
roll_choices correct model =
  let
    max_index = 
      (Array.length model.choice_data.bank - 1)

  in
  (
    model,
    Random.generate UpdateChoices (Random.pair (Random.list 4 (Random.int 0 max_index)) (Random.constant correct))
  )

update_choices : (List Int, Int) -> Model -> (Model, Cmd Msg)
update_choices (rolls, correct) model =
  (
    { model |
      choice_data = {
        bank = model.choice_data.bank,
        guess = NotGuessed,
        current = Just
          {
            correct = (get_correct correct rolls model.choice_data.bank),
            choices = (rolls_to_choices rolls [] model.choice_data.bank)
          }
      }
    },
    Cmd.none
  )

make_guess : Glyph -> Model -> (Model, Cmd Msg)
make_guess guess model =
  let
    (selected_choice, correct) = (case model.choice_data.current of
      Just x ->
        (
          (Maybe.withDefault ("E", "Error") 
            (List.head 
              (List.filter (check_guess guess) x.choices)
            )
          ), 
        x.correct)

      Nothing ->
        (("E", "Error"), ("E", "Error")))
  in
  (
    { model |
      choice_data = {
        bank = model.choice_data.bank,
        current = model.choice_data.current,
        guess = (if selected_choice == correct then Correct else Wrong)
      }
    },
    Cmd.none
  )


-- Helpers

check_guess : Glyph -> Glyph -> Bool
check_guess x guess =
  x == guess

page_to_bank : Pages -> GlyphList
page_to_bank page =
  case page of
    Hiragana -> Glyphs.hiragana
    Katakana -> Glyphs.katakana
    Kanji -> Glyphs.kanji
    Numbers -> Glyphs.numbers
    Combined -> Glyphs.combined
    _ -> Array.fromList []

rolls_to_choices : (List Int) -> (List Glyph) -> GlyphList -> (List Glyph)
rolls_to_choices rolls choices glyphs =
  if List.isEmpty rolls then
    choices
  else
    rolls_to_choices 
      (List.drop 1 rolls) 
      (
        case rolls of
          [] ->
            choices
          head :: _ ->
            choices ++ [(get_glyph_at_index head glyphs)]
      )
      glyphs

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