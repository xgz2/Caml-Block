type color = 
  | Blue
  | Green
  | Red
  | Orange
  | Yellow
  | Purple 
  | Brown

type h_off = int

type v_off = int

type block = 
  | Empty
  | Block of color * h_off * v_off

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

let rand_shape () = 
  let r = Random.int 13 in
  if r == 0 then OneByOne 
  else if r == 1 then TwoByTwo
  else if r == 2 then ThreeByThree
  else if r == 3 then OneByTwo
  else if r == 4 then TwoByOne
  else if r == 5 then OneByThree
  else if r == 6 then ThreeByOne
  else if r == 7 then OneByFour  
  else if r == 8 then FourByOne  
  else if r == 9 then OneByFive  
  else if r == 10 then FiveByOne  
  else if r == 11 then SymmetricalLTwo  
  else SymmetricalLThree 


let blocks_of_shape = function
  | OneByOne -> [Block (Blue, 0, 0)]
  | TwoByTwo -> [Block (Blue, 0, 0); Block (Blue, 1, 0); 
                 Block (Blue, 0, 1); Block (Blue, 1, 1)]
  | ThreeByThree -> [Block (Blue, 0, 0); Block (Blue, 1, 0); Block (Blue, 2, 0);
                     Block (Blue, 0, 1); Block (Blue, 1, 1); Block (Blue, 2, 1);
                     Block (Blue, 0, 2);  Block (Blue, 1, 2); Block (Blue, 2, 2)]
  | OneByTwo -> [Block (Green, 0, 0); Block (Green, 0, 1)]
  | TwoByOne -> [Block (Green, 0, 0); Block (Green, 1, 0)]
  | OneByThree -> [Block (Red, 0, 0); Block (Red, 0, 1); Block (Red, 0, 2)]
  | ThreeByOne -> [Block (Red, 0, 0); Block (Red, 1, 0); Block (Red, 2, 0)]
  | OneByFour -> [Block (Orange, 0, 0); Block (Orange, 0, 1); 
                  Block (Orange, 0, 2); Block (Orange, 0, 3)]
  | FourByOne -> [Block (Orange, 0, 0); Block (Orange, 1, 0); 
                  Block (Orange, 2, 0); Block (Orange, 3, 0)]
  | OneByFive -> [Block (Yellow, 0, 0); Block (Yellow, 0, 1); Block (Yellow, 0, 2); 
                  Block (Yellow, 0, 3); Block (Yellow, 0, 4)]
  | FiveByOne -> [Block (Yellow, 0, 0); Block (Yellow, 1, 0); Block (Yellow, 2, 0); 
                  Block (Yellow, 3, 0); Block (Yellow, 4, 0)]
  | SymmetricalLTwo -> [Block (Brown, 0, 0); Block (Brown, 0, 1); Block (Brown, 1, 1)]
  | SymmetricalLThree -> [Block (Brown, 0, 0); Block (Brown, 0, 1); Block (Brown, 0, 2); 
                          Block (Brown, 1, 2); Block (Brown, 2, 2)]

let string_of_block blk =
  match blk with
  | Empty -> Emoji.white_circle
  | Block (c,_,_) -> 
    match c with
    | Blue -> Emoji.blue_heart
    | Green -> Emoji.green_salad
    | Red -> Emoji.red_apple
    | Orange -> Emoji.orange_book
    | Yellow -> Emoji.full_moon_with_face
    | Purple -> Emoji.purple_heart
    | Brown -> Emoji.new_moon_face