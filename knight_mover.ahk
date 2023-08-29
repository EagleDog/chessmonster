;
;knight_moves.ahk
;
;
; KnightMoves(spot)
; MoveKnight1(spot)
; MoveKnight2(spot)
; MoveKnight3(spot)
;
;


; 1- find all possible jumps (target squares)
;  -- 8 possible jumps
; 2- eliminate out-of-board jumps
; 3- ID remaining target squares
; 4- attack opp if poss, else move to empty



KnightMoves(spot) {
  jumps := FindJumps(spot)
  jbounds := FindJBounds(spot, jumps)
  best_jump := MoveKnight2(spot, jumps, jbounds)
  if target {
    return target
  }
}

FindJBounds(spot, jumps) {
;  jumps := FindJumps(spot) ;[j1,j2,j3,j4,j5,j6,j7,j8]
  ;check boardbounds for target squares
  ; out-of-bounds < 1 or > 8
  ;   0 < bounds < 9
  jbounds := [1,1,1,1,1,1,1,1]
;  MsgBox, % "" . jumps[1] . " " . jumps[1][1] . " " . jumps[1][2] . " " . jumps[1].1 . ""
;  MsgBox, % "" jumps[1].1 . ""

  Loop, 8 {
    n := A_Index   ;  x value column   [n, n] [col, rank] [x, y]
      Loop, 2 {
        nn := A_Index    ; [1, 1] [2, 1] [3,1] [1,2] [2,2] [3,2]
        if ((jumps[n][nn] < 1) OR (jumps[n][nn] > 8)) {
          jbounds[n] := 0
      }
    }
  }
  return jbounds
}   ; end MoveKnight1(spot)


FindJumps(spot) {
  rank := board[spot].rank
  col := board[spot].column
  source := [col, rank]

  j1 := [col - 1, rank + 2]
  j2 := [col + 1, rank + 2]
  j3 := [col + 2, rank + 1]
  j4 := [col + 2, rank - 1]
  j5 := [col + 1, rank - 2]
  j6 := [col - 1, rank - 2]
  j7 := [col - 2, rank - 1]
  j8 := [col - 2, rank + 1]

  jumps := [j1, j2, j3, j4, j5, j6, j7, j8]
;  jumps := {j1:j2,j2:j2,j3:j3,j4:j4,j5:j5,j6:j6,j7:j7,j8:j8}

;  jumps[j1] := 

  ; jump_2_rank := rank + 1
  ; jump_2_col := col + 1
  ; jump_2_file := Chr(96 + jump_2_col)
  ; jump_2_spot := "" . jump_2_file . jump_2_rank . ""

;  MsgBox, % "jump_1: " . jump_1_spot . "  jump_2: " . jump_2_spot . ""

  return jumps
}


MoveKnight2(spot, jumps, jbounds) { 
  Loop, 8 {
    n := A_Index
    if (jbounds[n] = 1) {

    }
  }




}

MoveKnight3(spot) {  ; Forward One Square
  file := b[spot].file
  t_rank := b[spot].rank + 1
  target := "" . file . t_rank . ""
;  MsgBox, %target%
  if SqStat(target) = "empty" {
    return target
  } else {
    return
  }
}



