open Shape

type score = int

type coord = int * int

exception InvalidPlacement

module type BoardSig = sig
  type t 
  val init_board : t
  val block_from_location : t -> coord -> block
  val edit_board : t -> block -> coord -> t
  val check_block : t -> block -> coord -> bool
  val place_shape : t -> t -> block list -> coord -> t
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

  let block_from_location brd loc =
    List.assoc loc brd

  let edit_board brd block loc = 
    match loc with
      (x, y) -> 
      match block with
      | Block (c, x_block, y_block) ->
        let x_val = x + x_block in
        let y_val = y + y_block in
        ((x_val, y_val), block)::(List.remove_assoc (x_val, y_val) brd)
      | Empty -> 
        ((x, y), block)::(List.remove_assoc (x, y) brd)

  let check_block brd block loc =
    match loc with
    | (x,y) ->
      match block with
      | Block (c, x_block, y_block) ->
        let x_val = x + x_block in
        let y_val = y + y_block in
        if block_from_location brd (x_val, y_val) = Empty then true else false
      | Empty -> failwith "Imposible"

  let rec place_shape brd original_brd shape_blocks loc =
    try 
      (match shape_blocks with
       | [] -> brd
       | x::s -> 
         if check_block brd x loc 
         then place_shape (edit_board brd x loc) original_brd s loc 
         else original_brd)
    with Invalid_argument _ -> raise InvalidPlacement

  let rec print_board brd row col =
    if row >= 10 then (print_string "\n__________";)
    else if col >= 10 then 
      begin 
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
  val init_queue : t
  val get : t -> shape
  val replace : t -> t
end

module ShapeQueue : ShapeQueueSig = struct
  type t = shape list
  let rep_ok t = assert (List.length t = 3)
  let init_queue = [rand_shape (); rand_shape (); rand_shape ()]
  let get = function
    | x::s -> x
    | _ -> failwith "ShapeQueue Error: Empty ShapeQueue"
  let replace = function
    | x::s -> (rand_shape ())::(s |> List.rev) |> List.rev
    | _ -> failwith "ShapeQueue Error: Empty ShapeQueue"
end

type state = {
  current_score : score;
  current_board : Board.t;
  current_queue: ShapeQueue.t;
}

let init_state = {
  current_score = 0; 
  current_board = Board.init_board; 
  current_queue = ShapeQueue.init_queue;
}

let score_from_state st =
  st.current_score

let board_from_state st =
  st.current_board

let queue_from_state st = 
  st.current_queue

type result = Legal of state | Illegal

let step_place st shp loc =
  try
    let new_board = Board.place_shape (board_from_state st) 
        (board_from_state st) (blocks_of_shape shp) loc in
    let new_queue = ShapeQueue.replace (queue_from_state st) in
    Legal {current_score = score_from_state st; 
           current_board = new_board; current_queue = new_queue;}
  with InvalidPlacement -> Illegal


