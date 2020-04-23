open Shape
open State
open Command


let rec repl st =
  (* ANSITerminal. *)
  Stdlib.print_string("\nEnter a command: ");
  let parsed_command : Command.command = try (read_line() |> Command.parse)
    with
    | Empty -> print_endline "Please enter a non-emtpy command"; repl st
    | Malformed -> print_endline "Please enter a valid command"; repl st
  in

  match parsed_command with
  | Quit -> print_endline "Thank you for playing!"; exit 0
  | Place coords -> 
    let shp = st |> queue_from_state |> ShapeQueue.get in
    let x_coord = int_of_string (List.hd coords) in
    let y_coord = int_of_string (List.hd(List.tl coords)) in
    match (State.step_place st shp (x_coord, y_coord)) with
    | Legal st' -> repl st'
    | Illegal -> print_endline "Illegal coordinates. Please try again."; 
      repl st

(* let rec continued json st =
   ANSITerminal.(print_endline 
                  (st |> current_room_id 
                   |> description json));
   Stdlib.print_string ("\nEnter a command: ");
   try (match (read_line()) |> parse with
      |Quit -> print_endline "Thanks for playing!"; exit 0
      |Go object_phrase -> begin
          match (go (String.concat " " object_phrase) json st) with
          | Legal new_ -> continued json new_
          | Illegal -> print_endline "Please enter a valid exit."; continued json st
        end)
   with 
   | Empty -> print_endline "Please enter a non-empty exit."; continued json st
   | Malformed -> print_endline "Please enter a non-empty exit."; continued json st
   (** [play_game f] starts the adventure in file [f]. *)
   let play_game f =
   let json = Adventure.from_json (Yojson.Basic.from_file f) in 
   let init_state = State.init_state(json) in
   (* let score = 0 in *)
   continued json init_state
   (* Stdlib.print_string (Adventure.description json (Adventure.start_room json));
   Stdlib.print_string ("\nItems: ");
   Stdlib.print_string (Adventure.items j (State.current_room_id st));
   Stdlib.print_string ("\nPlease enter a command: "); *)

   continue_game json init_state score *)


let main () =
  ANSITerminal.(print_string [red]
                  "\n\nWelcome to the 3110 Text Adventure Game engine.\n");
  print_endline "Please enter the name of the game file you want to load.\n";
  print_string  "> ";
  match read_line () with
  | exception End_of_file -> ()
  | file_name -> play_game file_name

(* Execute the game engine. *)
let () = main ()