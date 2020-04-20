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

type grid = (block array) array 

type shape = 

  | OneByOne of grid
  | TwoByTwo of grid
  | ThreeByThree of grid

  | OneByTwo of grid
  | TwoByOne of grid

  | OneByThree of grid
  | ThreeByOne of grid

  | OneByFour of grid
  | FourByOne of grid

  | OneByFive of grid
  | FiveByOne of grid

  | SymmetricalLTwoR1 of grid
  | SymmetricalLTwoR2 of grid
  | SymmetricalLTwoR3 of grid 
  | SymmetricalLTwoR4 of grid
  
  | SymmetricalLThreeR1 of grid
  | SymmetricalLThreeR2 of grid
  | SymmetricalLThreeR3 of grid
  | SymmetricalLThreeR4 of grid