open Shape

type score = int

type board = ((bool * string) array) array

type shape_queue = Shape.shape * Shape.shape * Shape.shape

type state = board * score * shape_queue

let init_state = 

let print_state s = 