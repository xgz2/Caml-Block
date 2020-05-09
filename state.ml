open Shape
open Emoji

type score = int

type coord = int * int

exception InvalidPlacement

module type BoardSig = sig
  type t 
  val init_board : t
  val block_from_location : t -> coord -> block
  val edit_block_of_board : t -> block -> coord -> t
  val check_block_placement : t -> block -> coord -> bool
  val place_shape : t -> block list -> coord -> t
  val board_full : t -> int -> int -> shape -> bool
  val clear_board : t -> coord -> t
  val board_changes : t -> t -> int -> int
  val print_board : t -> int -> int -> unit
end

module Board : BoardSig = struct

  type t = (coord * block) list

  let init_board = 
    let rec new_board row acc size =
      let rec step_row col acc size =
        if col >= size then acc
        else step_row (col + 1) (((col, row), Empty)::acc) size 
      in
      if row >= size then acc
      else new_board (row + 1) ((step_row 0 [] size) @ acc) size
    in
    new_board 0 [] 10

  let board_size = init_board |> List.length 
                   |> float_of_int |> sqrt |> int_of_float

  let block_from_location brd loc =
    try List.assoc loc brd with Not_found -> raise InvalidPlacement

  let edit_block_of_board brd block loc = 
    match loc, block with
    | (x, y), Block (c, x_block, y_block) -> 
      let x_val = x + x_block in
      let y_val = y + y_block in
      ((x_val, y_val), block)::(List.remove_assoc (x_val, y_val) brd)
    | (x, y), Empty -> ((x,y),block)::(List.remove_assoc (x,y) brd)

  let check_block_placement brd block loc =
    match loc, block with
    | (x, y), Block (c, x_block, y_block) -> 
      let x_val = x + x_block in
      let y_val = y + y_block in
      if block_from_location brd (x_val, y_val) = Empty then true else false
    | _, Empty -> failwith "Imposible"

  let rec place_shape brd shape_blocks loc =
    match shape_blocks with
    | [] -> brd
    | x::s -> 
      if check_block_placement brd x loc 
      then place_shape (edit_block_of_board brd x loc) s loc 
      else raise InvalidPlacement

  (** [check_shape_list brd coord shp_lst] is if [shp_list] is empty. *)
  let rec check_shape_list brd coord shp_list =
    match shp_list with
    | [] -> true
    | x::s -> if check_block_placement brd x coord 
      then check_shape_list brd coord s 
      else false

  let rec board_full brd col row shp = 
    let blocks = blocks_of_shape shp in
    if col < board_size && row < board_size then 
      try
        if check_shape_list brd (col,row) blocks then false
        else board_full brd (col + 1) row shp
      with InvalidPlacement -> board_full brd (col + 1) row shp
    else if row < board_size then
      board_full brd 0 (row + 1) shp
    else true

  (** [check_full_row brd row] is [Some row] if row [row] on board [brd] is 
      full. Otherwise it is [None].
      Requires [row] is a valid row in the board. *)
  let check_full_row brd row =
    if (List.length (List.filter (fun ((x, y), b) -> y = row && b <> Empty) brd) 
        = board_size)
    then Some row else None

  (** [check_full_col brd col] is [Some col] if col [col] on board [brd] is 
      full. Otherwise it is [None].
      Requires [col] is a valid col in the board. *)
  let check_full_col brd col =
    if (List.length (List.filter (fun ((x, y), b) -> x = col && b <> Empty) brd) 
        = board_size)
    then Some col else None

  (** [clear_full_rows brd row_lst] is the board with all blocks in the rows of 
      [row_lst] equal to Empty. *)
  let rec clear_full_rows brd row_lst = 
    match row_lst with
    | [] -> brd
    | h::t -> clear_full_rows (List.fold_left (fun acc ((x,y), b) -> 
        if y = h then ((x,y), Empty)::acc 
        else ((x,y),b)::acc) [] brd) t

  (** [clear_full_cols brd row_lst] is the board with all blcoks in the cols of
      [col_lst] equal to Empty. *)
  let rec clear_full_cols brd col_lst = 
    match col_lst with
    | [] -> brd
    | h::t -> clear_full_cols (List.fold_left (fun acc ((x,y), b) -> 
        if x = h then ((x,y), Empty)::acc 
        else ((x,y),b)::acc) [] brd) t

  (** [clear_board t loc col_acc row_acc col_n and row_n] is the board with all
      full rows or columns set to empty. Board [t] is the board to change. Coord
      [loc] is the location when analysis of changes begins. Int [col_n] is the
      number of columns that the function checks (for time efficiency) and 
      similarly for [row_n] and rows. 
      Requires: [row_acc] = [[]] and [col_acc] = [[]]. *)
  let rec clear_board_aux (brd:t) (loc:coord) (col_acc:int list) (row_acc:int list) 
      (col_iterations:int) (row_iterations:int) : t = 
    match loc with
    | (col, row) -> 
      if (col < board_size && col_iterations > 0) then
        match check_full_col brd col with
        | None -> clear_board_aux brd (col + 1, row) col_acc row_acc 
                    (col_iterations - 1) row_iterations 
        | Some c -> clear_board_aux brd (col + 1, row) (c::col_acc) row_acc 
                      (col_iterations - 1) row_iterations 
      else if (row < board_size && row_iterations > 0) then
        match check_full_row brd row with
        | None -> clear_board_aux brd (col, row + 1) col_acc row_acc 
                    col_iterations (row_iterations - 1)
        | Some r -> clear_board_aux brd (col, row + 1) col_acc (r::row_acc) 
                      col_iterations (row_iterations - 1)
      else
        clear_full_rows (clear_full_cols brd col_acc) row_acc

  let clear_board brd loc =
    clear_board_aux brd loc [] [] 10 10

  let board_changes (brd1 : t) (brd2 : t) (acc:int) = 
    List.fold_left (fun acc ((x,y),b) -> 
        if (List.assoc (x,y) brd1) <> b then acc + 1 
        else acc) acc brd2

  let rec print_board brd row col =
    if row >= 10 then 
      begin
        print_string "0 1 2 3 4 5 6 7 8 9";
        print_string "\n"
      end
    else if col >= 10 then 
      begin 
        print_int (row);
        print_string "\n"; 
        print_board brd (row + 1) 0
      end
    else 
      begin
        let blk = block_from_location brd (col,row) |> string_of_block in
        print_string blk; 
        print_board brd row (col + 1)
      end

end 

module type ShapeQueueSig = sig
  type t
  val rep_ok : t -> unit
  val init_queue : unit -> t
  val get : t -> shape
  val replace : t -> t
  val print_queue : t -> unit
  val list_of_queue : t -> shape list
end

module ShapeQueue : ShapeQueueSig = struct
  type t = shape list

  let rep_ok t = assert (List.length t = 3)

  let init_queue () = Random.self_init (); 
    [rand_shape (); rand_shape (); rand_shape ()]

  let get = function
    | x::s -> x
    | _ -> failwith "ShapeQueue Error: Empty ShapeQueue"

  let replace = function
    | x::s -> s |> List.rev |> List.cons (rand_shape ()) |> List.rev
    | _ -> failwith "ShapeQueue Error: Empty ShapeQueue"

  let rec print_row blk_lst row col =
    match blk_lst with
    | [] -> ()
    | x::s ->
      match x with
      | Empty -> failwith "Block was empty"
      | Block (c, x, y) -> 
        if y = row && x = col then 
          (print_string (string_of_block (Block(c,x,y))); 
           print_row s row (col +1)) 
        else if y = row && x < col then print_row blk_lst row (col - 1)
        else if y = row then (print_row blk_lst row (col + 1))
        else print_row s row (col + 1)

  let rec print_shape s =
    let blocks = s |> blocks_of_shape in
    print_row blocks 0 0; print_string "\n";
    print_row blocks 1 0; print_string "\n";
    print_row blocks 2 0; print_string "\n";
    print_row blocks 3 0; print_string "\n";
    print_row blocks 4 0; print_string "\n"; print_string "\n"

  let rec print_queue t = 
    match t with
    | [] -> print_string "\n"
    | x::s -> print_shape x; print_queue s 

  let list_of_queue (t : t) = 
    List.filter (fun x -> x = x) t
end

type state = {
  current_score : score;
  current_board : Board.t;
  current_queue: ShapeQueue.t;
}

let init_state = {
  current_score = 0; 
  current_board = Board.init_board; 
  current_queue = ShapeQueue.init_queue ();
}

let score_from_state st =
  st.current_score

let board_from_state st =
  st.current_board

let queue_from_state st = 
  st.current_queue

let increment_score st s = {
  current_score = (score_from_state st) + s; 
  current_board = board_from_state st; 
  current_queue = queue_from_state st
}

type result = Legal of state | Illegal

let step_place st shp loc =
  try
    let current_board = board_from_state st in
    let blocks = blocks_of_shape shp in
    let new_board = Board.place_shape current_board blocks loc in
    let new_board_cleared = Board.clear_board new_board loc in
    let new_queue = ShapeQueue.replace (queue_from_state st) in
    Legal {
      current_score = (score_from_state st) + 1 + 
                      (Board.board_changes new_board new_board_cleared 0); 
      current_board = new_board_cleared; 
      current_queue = new_queue;
    }
  with InvalidPlacement -> Illegal


