open Shape
open Command
open State
open ShapeQueue
open Board

let rec repl st =
  print_string "\n\n";
  if board_full (board_from_state st) 0 0 (st |> queue_from_state |> get) 
  then (ANSITerminal.(print_string [red] "Game Over."); exit 0);
  print_string ("Score: " ^ (string_of_int (score_from_state st)));
  print_string "\n\n";
  print_board (board_from_state st) 0 0;
  print_string "\n";
  print_queue (queue_from_state st);
  print_string "\nEnter a command: ";
  let parsed_command : command = try (read_line() |> parse)
    with
    | Empty -> print_endline "Please enter a non-empty command"; repl st
    | Malformed -> print_endline "Please enter a valid command"; repl st
  in

  match parsed_command with
  | Quit -> print_endline "Thank you for playing!"; exit 0
  (* [coords] is guaranteed to be non-empty and of length 2. *)
  | Place coords -> 
    let shp = st |> queue_from_state |> get in
    let x_coord = (List.hd coords) in
    let y_coord = (List.hd(List.tl coords)) in
    match (step_place st shp (x_coord, y_coord)) with
    | Legal st' -> repl st'
    | Illegal -> print_endline "Illegal coordinates. Please try again."; 
      repl st

let parse_start () =
  print_endline "\n\nWould you like to begin now (y/n)?";
  print_string "\n>_";
  let response = read_line() in
  if response = "y" then (print_string "Great!";)
  else (print_string "ok"; exit 0)

let main () =
  ANSITerminal.(print_string [red]
                  "\n\nWelcome to Caml Blocks. In this game, your objective is
                  \nto place blocks onto the game board until you fill up a row.
                  \nUpon doing so, the row will clear and you will earn points 
                  \nequal to the number of blocks you cleared. Note that
                  \nwhile we show you three future shapes, you can only
                  \nplace the left most one. When placing a shape, you will 
                  \nspecify the location of its top left corner. 
                  \nThe command to place is 'place [column#] [row#]'!
                  \nHappy placing!"
               );
  ignore(parse_start ());
  ignore(repl init_state)

let () = main ()