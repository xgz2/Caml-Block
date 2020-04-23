open Shape
open State

type command = 
  | Place of 
      | Quit

exception Empty

exception Malformed

(** [parse str] is a command that is parsed from [str] into a verb and an 
    object phrase. Every word is a string of characters with no space character.
    The first word is the verb and the rest of the [str], if not
    empty, becomes the object phrase.
    Requires: [str] must be of ASCII character codes 0-9, 32, 65-90, 97-122.
    Raises: [Empty] if [str] contains nothing but space or none at all.
    Raises: [Malformed] if 1) verb is not "quit" or "go", 
    or 2) if verb is "quit" with some object phrase, 
    or 3) if verb is "go" but there is no object-phrase. *)
let parse str =
  let trim_word = String.trim str in
  let word_list_with_space = String.split_on_char ' ' trim_word in
  let word_list = List.filter (fun x ->  x <> "") word_list_with_space in
  (* let word_list = String.split_on_char ' ' str in *)
  match word_list with
  | [] -> raise Empty
  | "go"::[] -> raise Malformed
  | "go"::t -> Go (t)
  | "quit"::[] -> Quit
  | _ -> raise Malformed

