(** Type of colors. *)
type color = 
  | Blue
  | Green
  | Red
  | Orange
  | Yellow
  | Purple 
  | Brown

(** Type of horizontal offset. *)
type h_off = int
(** Type of vertical offset. *)
type v_off = int

(** Type of a singular board block. *)
type block = 
  | Empty
  | Block of color * h_off * v_off

(** Type of a playable shape. *)
type shape = 
  | OneByOne  
  | TwoByTwo  
  | ThreeByThree  
  | OneByTwo  
  | TwoByOne  
  | OneByThree  
  | ThreeByOne  
  | OneByFour  
  | FourByOne  
  | OneByFive  
  | FiveByOne  
  | SymmetricalLTwo  
  | SymmetricalLThree 

val rand_shape : unit -> shape

val blocks_of_shape : shape -> block list

val string_of_block : block -> string