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

module Board : BoardSig


module type ShapeQueueSig = sig
  type t
  val rep_ok : t -> unit
  val init_queue : t
  val get : t -> shape
  val replace : t -> t
end

module ShapeQueue : ShapeQueueSig


type state

val init_state : state

val score_from_state : state -> score

val board_from_state : state -> Board.t

val queue_from_state : state -> ShapeQueue.t

type result = Legal of state | Illegal

val step_place : state -> shape -> coord -> result