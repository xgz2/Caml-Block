open Shape

(** [score] is the type of the numerical score of the current state. *)
type score = int

(** [coord] is the type of a coordinate on the board. *)
type coord = int * int

(** [BoardSig] is the type of a board. *)
module type BoardSig = sig

  type t 

  (** [init_board] is the initial empty board. *)
  val init_board : t

  (** [block_from_location t coord] is the block associated with location 
      [coord] on the game board [t]. *)
  val block_from_location : t -> coord -> block

  (** [edit_block_of_board brd block loc] is the new board [brd] after [block] is added at location [loc]. *)
  val edit_block_of_board : t -> block -> coord -> t

  (** [check_block t b c] is if placing block [b] at coordinate [c] on 
      board [t] is valid. Returns true or false. *)
  val check_block_placement : t -> block -> coord -> bool

  (** [place_shape brd original_brd shape_blocks loc] is the placing of 
      the [shape_blocks] onto [brd] in location [loc].
      Raises: [InvalidPlacement] if placement conflicts with existing shapes. *)
  val place_shape : t -> block list -> coord -> t

  val board_full : t -> int -> int -> shape -> bool

  val clear_board : t -> coord -> int list -> int list -> int -> int -> t


  val board_changes : t -> t -> int -> int

  (** [print_board brd row col] is printing of the current game board. *)
  val print_board : t -> int -> int -> unit
end

module Board : BoardSig

(** [ShapeQueueSig] is the type of a queue of shapes. *)
module type ShapeQueueSig = sig

  type t

  (** [rep_ok] asserts that the representation of a shape queue is valid.
      AF: a [ShapeQueueSig] is a list of three random Shapes.
      RI: The list must have length of exactly three. *)
  val rep_ok : t -> unit

  (** [init_queue] is an initial queue of three shapes. *)
  val init_queue : t

  (** [get t] is the head of the ShapeQueueSig. *)
  val get : t -> shape

  (** [replace t] is a new ShapeQueueSig with the original first element removed
      and a new element appended to the end of the structure. *)
  val replace : t -> t

  (** [print_queue t] prints the current ShapeQueueSig to the terminal
      and returns [unit]. *)
  val print_queue : t -> unit
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