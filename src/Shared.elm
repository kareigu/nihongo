module Shared exposing (..)
import Array exposing (Array)

type Msg
  = ChangePage Pages
  | UpdateChoices (List Int, Int) 
  | RollChoices Int

type Pages
  = Menu
  | Katakana
  | Hiragana
  | Kanji
  | Numbers
  | Combined


type alias Model =
  {
    choice_data : ChoiceData,
    selectedPage : Pages
  }

type alias ChoiceData =
  {
    current : Maybe CurrentChoice,
    bank : GlyphList
  }

type alias CurrentChoice =
  {
    correct : Glyph,
    choices : List Glyph
  }

type alias Glyph = (String, String)
type alias GlyphList = Array Glyph
