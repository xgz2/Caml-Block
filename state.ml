open Shape

type score = int

type board = (block array) array

let shape_array =  

module shape_queue = struct
  type t = Shape.shape * Shape.shape * Shape.shape
  let rand_shape = 

  type state = score * board * shape_queue

  let init_state = (0, Array.make_matrix 10 10 Empty, )

  let print_state s = 