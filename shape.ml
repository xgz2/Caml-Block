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

(* https://ocaml.org/learn/tutorials/99problems.html *)

type shape = 
(* color 1 *)
  | OneByOne of grid
  | TwoByTwo of grid
  | ThreeByThree of grid
(* color 2 *)
  | OneByTwo of grid
  | TwoByOne of grid
(* color 3 *)
  | OneByThree of grid
  | ThreeByOne of grid
(* color 4 *)
  | OneByFour of grid
  | FourByOne of grid
(* color 5 *)
  | OneByFive of grid
  | FiveByOne of grid
(* color 6 *)
  | SymmetricalLTwoR1 of grid
  | SymmetricalLTwoR2 of grid
  | SymmetricalLTwoR3 of grid 
  | SymmetricalLTwoR4 of grid
(* color 7 *)
  | SymmetricalLThreeR1 of grid
  | SymmetricalLThreeR2 of grid
  | SymmetricalLThreeR3 of grid
  | SymmetricalLThreeR4 of grid




(* 3x3, , , symmetrical L shape with length 3 in all four rotations, 
   symmetrical L shape with length 2 in all four rotations, 
   4x1, 5x1 *)


(* http://www.unicode.org/emoji/charts/emoji-list.html *)
(* https://github.com/fxfactorial/ocaml-emoji *)
(* https://hyegar.com/ocaml-emoji/ *)
(* https://stackoverflow.com/questions/56432257/how-to-print-a-unit-in-ocaml-beginner *)

(* 🔳🔲▪️▫️◾️◽️◼️◻️🟥🟧🟨🟩🟦🟪⬛️⬜️🟫 *)

🟥
🟥
🟥🟥🟥



(* 3x3, 2x2, 1x1, symmetrical L shape with length 3 in all four rotations, 
   symmetrical L shape with length 2 in all four rotations, 1x2, 1x3, 1x4, 1x5, 
   2x1, 3x1, 4x1, 5x1 *)







(* ___________
   |
   |
   | *)
