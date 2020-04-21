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
