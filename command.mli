open Shape
open State

(** [command_phrase] is the type of parsed player commands after the first word
    entered. A [command_phrase] is not permitted to be an empty list. *)
type command_phrase = int list

(** The type [command] represents a player command that is decomposed
    into a verb and possibly an command phrase. *)
type command = 
  | Place of command_phrase
  | Quit

(** Raised when an empty command is formed. *)
exception Empty

(** Raised when a malformed command is encountered. *)
exception Malformed

(** [parse str] is a command that is parsed from [str] into a verb and an 
    command_phrase. Every word is a string of characters with no space 
    characters. The first word is the verb and the rest of the [str], if not
    empty, becomes the command_phrase.
    Requires: [str] must be of ASCII character codes 0-9, 32, 65-90, 97-122.
    Raises: [Empty] if [str] contains nothing but space or none at all.
    Raises: [Malformed] if 
    1) verb is not "quit" or "place", 
    or 2) if verb is "quit" with some command_phrase, 
    or 3) if verb is "place" but there is no command_phrase,
    or 4) if verb "place" follows one or two non-integer argument(s). *)
val parse : string -> command