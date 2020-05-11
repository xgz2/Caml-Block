(** [color] is the type of colors. *)
type color = 
  | Blue
  | Green
  | Red
  | Orange
  | Yellow
  | Purple 
  | Brown

(** [h_off] is the type of horizontal offset. *)
type h_off = int

(** [v_off] is the type of vertical offset. *)
type v_off = int

(** [block] is the type of a singular board block. *)
type block = 
  | Empty
  | Block of color * h_off * v_off

(** [shape] is the type of a playable shape. *)
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

(** [rand_shape] is a random shape randomly selected from all 13 
    different shapes. *)
val rand_shape : unit -> shape

(** [blocks_of_shape] is the creation of the 13 shapes from their 
    respective blocks. *)
val blocks_of_shape : shape -> block list

(** [string_of_block b] is the emoji associated with a block of 
    certain color. *)
val string_of_block : block -> string