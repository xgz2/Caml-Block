open Shape
open State
open Command


let rec repl st =
  print_string "\n\n";
  Board.print_board (board_from_state st) 0 0;
  print_string "\n";
  ShapeQueue.print_queue (queue_from_state st);
  print_string "\nEnter a command: ";
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

let parse_start () =
  print_endline "\n\nWould you like to begin now (y/n)?";
  print_string "\n_>";
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
                  \nspecify the location of its top left corner. Happy placing!"
               );
  ignore(parse_start ());
  ignore(repl State.init_state)

let () = main ()