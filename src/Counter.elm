module Counter exposing (counter, update_counter)

import Html exposing (button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Shared exposing (Msg(..), CounterMsg(..), Model)

update_counter : CounterMsg -> Int -> Int
update_counter msg count =
  case msg of
    Increment ->
      count + 1

    Decrement ->
      if count > 0 then count - 1 else count


counter : Model -> Html.Html Msg
counter model =
  div
    [ class "flex p-4" ]
    [ button [ class "btn m-4", onClick (UpdateCounter Decrement) ] 
        [ text "-" ],
      div [ class "m-4 font-bold text-xl text-gray-600" ] 
        [ text (String.fromInt model.count) ],
      button [ class "btn m-4", onClick (UpdateCounter Increment) ] 
        [ text "+" ]
    ]
