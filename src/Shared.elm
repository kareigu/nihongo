module Shared exposing (..)

type Msg
  = UpdateCounter CounterMsg
  | ChangePage Pages

type CounterMsg
  = Increment
  | Decrement

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