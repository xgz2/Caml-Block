open Shape
open State

type command_phrase = string list

type command = 
  | Place of command_phrase
  | Quit

exception Empty

exception Malformed

let parse str =
  let word_list = str |> String.trim |> String.split_on_char ' ' 
                  |> List.filter (fun x ->  x <> "") in
  let list_length = List.length word_list in
  match word_list with
  | [] -> raise Empty
  | h::t ->
    if h = "place" && list_length = 3 then Place t
    else if h = "quit" && list_length = 1 then Quit
    else raise Malformed