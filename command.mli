open Shape
open State

type command_phrase = string list

type command = 
  | Place of command_phrase
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
val parse : string -> command