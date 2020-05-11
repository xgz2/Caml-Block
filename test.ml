open Shape
open State
open Command
open Emoji
open OUnit2
open Board
open ShapeQueue

(* Test Plan: To test the correctness of our system, we employed black box 
   testing. Our initial test design always worked in the black box method 
   because we would only look at mli files and base our methods off the exposed 
   functionaliy. The modules that were automatically tested by OUnit are 
   Board and ShapeQue. In addition, we also tested the states of our game and 
   the commands using OUnit. However, occasionally a test would be a bit more 
   difficult to build and we would consult our internal code to think of an 
   effective testing approach. We tested all the exposed functions in State 
   (including Board and ShapeQueue) and Command. We tested based on proper 
   returns and purposeful improper returns (checking that correct exceptions 
   were raised). We did not test internal helper functions because these would
   be used during the testing of other exposed functions so we can have a high 
   degree of confidence. We also did not test exposed functions made 
   specifically for testing purposes. We did not test print functions with OUnit 
   and instead tested through play testing to ensure that representation of 
   boards, shapes, and queues printed as one would expect. We did not test the 
   functions in Shape with OUnit because one returns a random shape, one returns 
   a block list that had to be manually coded, and another returns emoji 
   representations that had to be manually coded. Instead, these were tested 
   through extensive play testing to ensure that shapes were indeed random 
   (and all shapes appeared), shapes appeared in the correct orientation, and 
   the proper emojis displayed. Finally, we believe that our test suite gives 
   proper confidence to the correct function of our game because not only does 
   the game hold proper through many play tests but also our tests for the 
   function of nearly all of our functions holds correct to the expected output.
   These play tests and unit tests give us a high level of confidence that our 
   system fulfills our spec and ergo all purposes we designated.
*)


let board_1x1 = edit_block_of_board init_board (Block (Blue, 0,0)) (0,0)
let blocks_of_1x1 = blocks_of_shape OneByOne
let blocks_of_2x2 = blocks_of_shape TwoByTwo
let blocks_of_3x3 = blocks_of_shape ThreeByThree
let blocks_of_1x3 = blocks_of_shape OneByThree
let blocks_of_1x5 = blocks_of_shape OneByFive
let blocks_of_1x4 = blocks_of_shape OneByFour
let blocks_of_5x1 = blocks_of_shape FiveByOne
let blocks_of_4x1 = blocks_of_shape FourByOne

let board_of_5x1 = place_shape init_board blocks_of_5x1 (0,0)
let board_of_5x1_times2 = place_shape board_of_5x1 blocks_of_5x1 (5,0)


let board_of_3x3 = place_shape init_board blocks_of_3x3 (0,0)
let board_of_3x3_times_2 = place_shape board_of_3x3 
    blocks_of_3x3 (3,0)
let board_of_3x3_times_3 = place_shape board_of_3x3_times_2 
    blocks_of_3x3 (6,0)
let board_of_3x3_times_4 = place_shape board_of_3x3_times_3 
    blocks_of_3x3 (0,3)
let board_of_3x3_times_5 = place_shape board_of_3x3_times_4 
    blocks_of_3x3 (3,3)
let board_of_3x3_times_6 = place_shape board_of_3x3_times_5 
    blocks_of_3x3 (6,3)
let board_of_3x3_times_7 = place_shape board_of_3x3_times_6 
    blocks_of_3x3 (0,6)
let board_of_3x3_times_8 = place_shape board_of_3x3_times_7 
    blocks_of_3x3 (3,6)
let board_of_3x3_times_9 = place_shape board_of_3x3_times_8 
    blocks_of_3x3 (6,6)
let clear_3_rows = place_shape board_of_3x3_times_9 
    blocks_of_1x3 (9,0)

let full_board_prep_1 = place_shape board_of_3x3_times_9 blocks_of_1x5 (9,0)
let full_board_prep_2 = place_shape full_board_prep_1 blocks_of_1x5 (9,5)
let full_board_prep_3 = place_shape full_board_prep_2 blocks_of_5x1 (0,9)
let full_board = place_shape full_board_prep_3 blocks_of_4x1 (5,9)

let queue = init_queue ()



let tests = [
  "Test 1: [block_from_location init_board (0,0)] is Empty" >:: (fun _ ->
      assert_equal Shape.Empty (block_from_location init_board (0,0)));

  "Test 2: [edit_block_of_board init_board Block (Brown, 0, 0) (0,0)]" >:: 
  (fun _ ->
     assert_equal (Block (Blue, 0,0)) 
       (block_from_location board_1x1 (0, 0))); 

  "Test 3: [check_block_placement] valid placement" >:: (fun _ ->
      assert_equal true 
        (check_block_placement board_1x1 (Block (Red,0,0)) (5,5)));

  "Test 4: [check_block_placement] invalid placement (overlap)" >:: (fun _ ->
      assert_equal false 
        (check_block_placement board_1x1 (Block (Red,0,0)) (0,0)));

  "Test 5: [check_block_placement] invalid placement (off board)" >:: 
  (fun _ ->
     assert_raises InvalidPlacement (fun _ -> 
         (check_block_placement board_1x1 (Block (Red,0,0)) (20,300)))); 

  "Test 6: [place_shape brd shape_blocks loc] invalid (overlap)" >:: 
  (fun _ ->
     assert_raises InvalidPlacement (fun _ -> 
         (place_shape board_1x1 blocks_of_2x2 (0,0))));

  "Test 7: [place_shape brd shape_blocks loc] invalid (off board)" >:: 
  (fun _ ->
     assert_raises InvalidPlacement (fun _ ->
         (place_shape board_1x1 blocks_of_2x2 (20,20))));

  "Test 8: [place_shape brd shape_blocks loc] invalid (partial off board)" >:: 
  (fun _ ->
     assert_raises InvalidPlacement (fun _ ->
         (place_shape board_1x1 blocks_of_2x2 (9,9))));

  "Test 9: [place_shape brd shape_blocks loc] invalid (overlapping)" >:: 
  (fun _ ->
     assert_raises InvalidPlacement (fun _ ->
         (place_shape board_1x1 blocks_of_2x2 (0,0))));

  "Test 10: [place_shape] is valid" >:: (fun _ ->
      assert_equal (Block (Blue, 0, 0)) 
        (block_from_location 
           (place_shape init_board blocks_of_1x1 (0,0)) 
           (0,0)));

  "Test 11: [board_full] is true" >:: (fun _ ->
      assert_equal true (board_full board_of_3x3_times_9 0 0 TwoByTwo));

  "Test 12: [board_full] is false" >:: (fun _ ->
      assert_equal false (board_full init_board 0 0 OneByOne));

  "Test 13: [board_full] is false" >:: (fun _ ->
      assert_equal false (board_full board_of_3x3_times_9 0 0 OneByOne));

  "Test 14: [clear_board] of empty board is empty board" >:: (fun _ ->
      assert_equal init_board (clear_board init_board (0,0)));

  "Test 15: [clear_board] of one line is empty board" >:: (fun _ ->
      assert_equal 0 
        (board_changes init_board 
           (clear_board board_of_5x1_times2 (0,0)) 0));

  "Test 16: [board_changes] of [init_board] and [full_board] is 100" >:: 
  (fun _ ->
     assert_equal 100 (board_changes init_board full_board 0));

  "Test 17: [board_changes] of [full_board] and [init_board] is 100" >:: 
  (fun _ ->
     assert_equal 100 (board_changes full_board init_board 0));

  "Test 18: [board_changes] of [board_1x1] and [full_board] is 1" >:: 
  (fun _ ->
     assert_equal 1 (board_changes board_1x1 init_board 0));

  "Test 19: [board_changes] of [board_1x1] and [full_board] is 99" >:: 
  (fun _ ->
     assert_equal 99 (board_changes board_1x1 full_board 0));

  "Test 20: [init_queue] has length 3" >:: 
  (fun _ ->
     assert_equal 3 (queue |> list_of_queue |> List.length));

  "Test 21: [get] returns the head of the ShapeQueue" >:: (fun _ -> 
      assert_equal (queue |> list_of_queue |> List.hd) (get queue));

  "Test 22: [replace] still maintains a length of 3" >:: (fun _ ->
      assert_equal 3 (queue |> replace |> list_of_queue |> List.length));

  "Test 23: [replace] makes the second in queue the first" >:: (fun _ ->
      assert_equal (queue |> list_of_queue |> List.tl |> List.hd) 
        (queue |> replace |> get));

  "Test 24: [init_state] has a score of 0 using [score_from_state]" >:: 
  (fun _ -> 
     assert_equal 0 (init_state |> score_from_state));

  "Test 25: [init_state] has an empty board using [score_from_state]" >:: 
  (fun _ ->
     assert_equal init_board (init_state |> board_from_state));

  "Test 26: [init_state] has a proper [ShapeQueue] using [score_from_state]" >:: 
  (fun _ ->
     assert_equal () (init_state |> queue_from_state |> rep_ok));

  "Test 27: [step_place] Legal" >:: (fun _ -> 
      match step_place init_state OneByOne (0,0) with
      | Legal t ->  assert_equal 1 (score_from_state t); 
        assert_equal 1 (board_changes (t |> board_from_state) init_board 0);
      | Illegal -> assert_failure "Should be Legal");

  "Test 28: [step_place] Illegal" >:: (fun _ -> 
      match step_place init_state OneByOne (100,0) with
      | Legal t ->  assert_failure "Should be Illegal"
      | Illegal -> assert_equal Illegal Illegal);

  "Test 29: [step_place] Illegal" >:: (fun _ -> 
      match step_place init_state TwoByTwo (9,9) with
      | Legal t ->  assert_failure "Should be Illegal"
      | Illegal -> assert_equal Illegal Illegal);

  "Test 30: [parse] raises Empty (empty)" >:: (fun _ -> 
      assert_raises Empty (fun _ -> parse ""));

  "Test 31: [parse] raises Empty (spaces)" >:: (fun _ -> 
      assert_raises Empty (fun _ -> parse "       "));

  "Test 32: [parse] raises Malformed (spelling - place)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "plac 0 0"));

  "Test 33: [parse] raises Malformed (nonsense)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "p"));

  "Test 34: [parse] raises Malformed (spelling - quit)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "qui"));

  "Test 35: [parse] raises Malformed (too short - missing arg" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "place 1"));

  "Test 36: [parse] raises Malformed (quit too long)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "quit 1 2"));

  "Test 37: [parse] raises Malformed (place cord w/ 3 arg)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "place 1 1 1"));

  "Test 38: [parse] raises Malformed (place strings)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "place yes no"));

  "Test 39: [parse] raises Malformed (place one string)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "place yes"));

  "Test 40: [parse] raises Malformed (quit string)" >:: (fun _ ->
      assert_raises Malformed (fun _ -> parse "quit yes"));

  "Test 41: [parse] correct (quit - spaces)" >:: (fun _ ->
      assert_equal Quit (parse "     quit     "));

  "Test 42: [parse] correct (quit)" >:: (fun _ ->
      assert_equal Quit (parse "quit"));

  "Test 43: [parse] correct (place)" >:: (fun _ ->
      assert_equal (Place [20; 0]) (parse "place 20 0"));

  "Test 44: [parse] correct (place w/ space)" >:: (fun _ ->
      assert_equal (Place [0; 0]) (parse "place      0     0"));

  "Test 45: [parse] correct (place)" >:: (fun _ ->
      assert_equal (Place [0; 0]) (parse "place 0 0"));

  "Test 46: [clear_board] of empty board is empty board" >:: (fun _ ->
      assert_equal 0 
        (board_changes init_board (clear_board init_board (0,0)) 0));

  "Test 47: [clear_board] of [full_board] is empty board" >:: (fun _ ->
      assert_equal 0 
        (board_changes init_board (clear_board full_board (0,0)) 0));

  "Test 48: [clear_board] of one by one board does not change" >:: (fun _ ->
      assert_equal 1 
        (board_changes init_board (clear_board board_1x1 (0,0)) 0));

  "Test 49: [clear_board] of 3 ready rows add 1x3" >:: (fun _ ->
      assert_equal 27
        (board_changes board_of_3x3_times_9 
           (clear_board clear_3_rows (0,0)) 0));

  "Test 50: [block_from_location] invalid placement raises Invalid Placement"
  >:: (fun _ ->
      assert_raises InvalidPlacement 
        (fun _ -> block_from_location init_board (20,20)))
]


let suite = "suite" >::: tests

let () = run_test_tt_main suite
