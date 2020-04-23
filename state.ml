open Shape

type score = int

type coord = int * int

module type BoardSig = sig
  type t 
  val init_board : t
  val block_from_location : t -> coord -> block
  val edit_board : t -> block -> coord -> t
  val check_block : t -> block -> coord -> bool
  val place_shape : t -> t -> block list -> coord -> t
end

module Board : BoardSig = struct
  type t = (coord * block) list
  let init_board = 
    let rec new_board row acc =
      let rec step_row col acc =
        if col >= 10 then acc
        else step_row (col + 1) (((col, row), Empty)::acc) 
      in
      if row >= 10 then acc
      else new_board (row + 1) ((step_row 0 []) @ acc)
    in
    new_board 0 []

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
    match shape_blocks with
    | [] -> brd
    | x::s -> if check_block brd x loc 
      then place_shape (edit_board brd x loc) original_brd s loc 
      else original_brd
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


