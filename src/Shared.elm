module Shared exposing (..)
import Array exposing (Array)

type Msg
  = NoOp
  | ChangePage Pages
  | UpdateChoices (List Int, Int) 
  | RollChoices Int
  | MakeGuess Glyph
  | Reroll

type Pages
  = Menu
  | Katakana
  | Hiragana
  | Kanji
  | Numbers
  | Combined


type Guess
  = NotGuessed
  | Correct
  | Wrong

type alias Model =
  {
    choice_data : ChoiceData,
    selectedPage : Pages
  }

type alias ChoiceData =
  {
    current : Maybe CurrentChoice,
    guess : Guess,
    bank : GlyphList
  }

type alias CurrentChoice =
  {
    correct : Glyph,
    choices : List Glyph
  }

type alias Glyph = (String, String)
type alias GlyphList = Array Glyph
