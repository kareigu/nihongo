module Shared exposing (..)
import Array exposing (Array)

version : String
version =
  "v" ++
  "0.6.1"

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

default_model : Model
default_model =
  {
    choice_data = default_choicedata,
    selectedPage = Menu
  }

type alias ChoiceData =
  {
    current : Maybe CurrentChoice,
    guess : Guess,
    bank : GlyphList
  }

default_choicedata : ChoiceData
default_choicedata =
  {
    current = Nothing,
    bank = (Array.fromList []),
    guess = NotGuessed
  }

type alias CurrentChoice =
  {
    correct : Glyph,
    choices : Choices
  }

type alias Choices = List Glyph
type alias Rolls = List Int
type alias CorrectGlyph = Int

type alias Glyph = (String, String)
default_glyph : Glyph
default_glyph = ("E", "error")

unwrap_glyph : Maybe Glyph -> Glyph
unwrap_glyph to_unwrap =
  Maybe.withDefault default_glyph to_unwrap

type alias GlyphList = Array Glyph
