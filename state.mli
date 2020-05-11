open Shape

(** [score] is the type of the numerical score of the current state. *)
type score = int

(** [coord] is the type of a coordinate on the board. *)
type coord = int * int

(** Raised when the user attempts an invalid placement of a shape. For example,
    placing off the board or placing at a non-coordinate value. *)
exception InvalidPlacement

(** A [BoardSig] contains empty blocks and other blocks representing free spaces 
    for the player to place shapes or blocks the player has placed but have not 
    been cleared yet. *)
module type BoardSig = sig

  (** The type of a board. *)
  type t 

  (** [init_board] is the initial empty board of dimension 10. *)
  val init_board : t

  (** [block_from_location t coord] is the block associated with location 
      [coord] on the game board [t]. 
      Raises: [InvalidPlacement] if [coord] is not on board [t]. *)
  val block_from_location : t -> coord -> block

  (** [edit_block_of_board brd block loc] is the new board [brd] after [block] 
      is added at location [loc]. *)
  val edit_block_of_board : t -> block -> coord -> t

  (** [check_block t b c] is if placing block [b] at coordinate [c] on 
      board [t] is valid. 
      Requires: [b] is not [Empty]. *)
  val check_block_placement : t -> block -> coord -> bool

  (** [place_shape brd original_brd shape_blocks loc] is the placing of 
      the [shape_blocks] onto [brd] in location [loc].
      Raises: [InvalidPlacement] if placement conflicts with existing shapes. *)
  val place_shape : t -> block list -> coord -> t

  (** [board_full t col row shp] is if board [t] has no possible Legal placement
      of shape [shp]. 
      Requires: [col] and [row] are 0. *)
  val board_full : t -> int -> int -> shape -> bool

  (** [clear_board t loc] is the board with all full rows or columns set to 
      empty. This only considered rows below the y coordinate of [loc] and right
      of the x coordinate of [loc]. This is for the purpose of efficency in 
      board clearing. [loc] is the location of a shape placement when this is 
      called. *)
  val clear_board : t -> coord -> t

  (** [board_changes brd1 brd2 acc] is the integer number of block changes from 
      [brd1] to [brd2]. 
      Requires: [acc = 0]. *)
  val board_changes : t -> t -> int -> int

  (** [print_board brd row col] is prints board [t] to the terminal. *)
  val print_board : t -> int -> int -> unit

end
module Board : BoardSig

(** A [ShapeQueueSig] represents a list of exactly three shapes. The first shape
    is the shape that the player may select to place, and the two additional
    shapes are the shapes that will be allocated for the user to place in the
    next two rounds of the game respectively.  *)
module type ShapeQueueSig = sig

  (** The type of queues of shapes. *)
  type t

  (** [rep_ok] asserts that the representation of a shape queue is valid.
      AF: a [ShapeQueueSig] is a list of three random Shapes.
      RI: The list must have length of exactly three. *)
  val rep_ok : t -> unit

  (** [init_queue ()] is an initial random queue of three shapes. *)
  val init_queue : unit -> t

  (** [get t] is the head of the ShapeQueueSig. 
      Requires: [t] is nonempty. *)
  val get : t -> shape

  (** [replace t] is a new ShapeQueueSig with the original first element removed
      and a new element appended to the end of the structure. 
      Requires: [t] is nonempty. *)
  val replace : t -> t

  (** [print_queue t] prints the current ShapeQueueSig to the terminal
      and returns [unit]. *)
  val print_queue : t -> unit

  (** [list_of_queue t] is the ShapeQueue [t] as a list. *)
  val list_of_queue: t -> shape list
end

module ShapeQueue : ShapeQueueSig

(** The type of a certain state of a game. *)
type state

(** [init_state] is the beginning state of any game composed of an empty board,
    a specific shape queue, and a score of 0. *)
val init_state : state

(** [score_from_state s] is the current score stored in state [s]. *)
val score_from_state : state -> score

(** [board_from_state s] is the current board stored in state [s]. *)
val board_from_state : state -> Board.t

(** [queue_from_state s] is the current shape queue in state [s]. *)
val queue_from_state : state -> ShapeQueue.t

(** [result] is the type of player actions. *)
type result = Legal of state | Illegal

(** [step_place s shp coord] is the result of a placement in state [s]
    of shape [shp] at coordinate [coord]. *)
val step_place : state -> shape -> coord -> result