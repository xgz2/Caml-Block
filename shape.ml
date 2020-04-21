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

(** Type of a shape placement grid. *)
module Grid = struct
  type t = (block array) array
  let make c 
      x0y0 x1y0 x2y0 x3y0 x4y0 x5y0 
      x0y1 x1y1 x2y1 x3y1 x4y1 x5y0 
      x0y2 x1y2 x2y2 x3y2 x4y2 x5y2
      x0y3 x1y3 x2y3 x3y3 x4y3 x5y3
      x0y4 x1y4 x2y4 x3y4 x4y4 x5y4 = 

    (** Type of a playable shape. *)
    (* add Color *)
  type shape = 
    (* color 1 *)
    | OneByOne of color
    | TwoByTwo of color
    | ThreeByThree of color
    (* color 2 *)
    | OneByTwo of color
    | TwoByOne of color
    (* color 3 *)
    | OneByThree of color
    | ThreeByOne of color
    (* color 4 *)
    | OneByFour of color
    | FourByOne of color
    (* color 5 *)
    | OneByFive of color
    | FiveByOne of color
    (* color 6 *)
    | SymmetricalLTwoR1 of color
    | SymmetricalLTwoR2 of color
    | SymmetricalLTwoR3  of color
    | SymmetricalLTwoR4 of color
    (* color 7 *)
    | SymmetricalLThreeR1 of color
    | SymmetricalLThreeR2 of color
    | SymmetricalLThreeR3 of color
    | SymmetricalLThreeR4 of color

(* [[Empty;Empty;Empty;Empty;Empty];
   [Empty;Empty;Empty;Empty;Empty];
   [Empty;Empty;Empty;Empty;Empty];
   [Empty;Empty;Empty;Empty;Empty];
   [Empty;Empty;Empty;Empty;Empty]] *)

(* let grid_of_shape = function
   | OneByOne c -> Array.of_list [
      [Block(c,0,0);Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty]]
   | TwoByTwo c -> Array.of_list [
      [Block(c,0,0);Block(c,1,0);Empty;Empty;Empty];
      [Block(c,0,1);Block(c,1,1);Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty]]
   | ThreeByThree c 
   | OneByTwo c
   | TwoByOne c
   | OneByThree c
   | ThreeByOne c
   | OneByFour c
   | FourByOne c
   | OneByFive c
   | FiveByOne c
   | SymmetricalLTwoR1 c
   | SymmetricalLTwoR2 c
   | SymmetricalLTwoR3 c
   | SymmetricalLTwoR4 c
   | SymmetricalLThreeR1 c -> Array.of_list [
      [Block(c,0,0);Empty;Empty;Empty;Empty];
      [Block(c,0,0);Empty;Empty;Empty;Empty];
      [Block(c,0,0);Empty;Empty;Empty;Empty];
      [Block(c,0,0);Empty;Empty;Empty;Empty];
      [Empty;Empty;Empty;Empty;Empty]]
   | SymmetricalLThreeR2 c
   | SymmetricalLThreeR3 c
   | SymmetricalLThreeR4 c -> Array.of_list [] *)




(* 3x3, , , symmetrical L shape with length 3 in all four rotations, 
   symmetrical L shape with length 2 in all four rotations, 
   4x1, 5x1 *)

(* https://ocaml.org/learn/tutorials/99problems.html *)
(* http://www.unicode.org/emoji/charts/emoji-list.html *)
(* https://github.com/fxfactorial/ocaml-emoji *)
(* https://hyegar.com/ocaml-emoji/ *)
(* https://stackoverflow.com/questions/56432257/how-to-print-a-unit-in-ocaml-beginner *)





(* 3x3, 2x2, 1x1, symmetrical L shape with length 3 in all four rotations, 
   symmetrical L shape with length 2 in all four rotations, 1x2, 1x3, 1x4, 1x5, 
   2x1, 3x1, 4x1, 5x1 *)







(* ___________
   |
   |
   | *)
