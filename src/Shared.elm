module Shared exposing (..)

type Msg
  = ChangePage Pages

type Pages
  = Menu
  | Katakana
  | Hiragana
  | Kanji
  | Numbers
  | Combined


type alias Model =
  {
    count : Int,
    selectedPage : Pages
  }