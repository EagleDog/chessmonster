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

KnightMoves(spot) {
  target := MoveKnight1(spot)
  if target {
    return target
  }
}

MoveKnight1(spot) {  ; Jump Attack
  jumps := FindJumps(spot) ;array
  jump_1 := jumps[1] ;spot
  jump_2 := jumps[2] ;spot
  ; jump_1_status := SquareStatus(jump_1)
  ; jump_2_status := SquareStatus(jump_2)
  if (SqStat(jump_1) = opp_color) {
    return jump_1
  } else if (SqStat(jump_2) = opp_color) {
    return jump_2
  } else {
    return
  }
}

MoveKnight2(spot) {  ; Forward Two Squares
  file := b[spot].file  ; b-board
  t_rank_1 := b[spot].rank + 1  ; t-target
  t_rank_2 := b[spot].rank + 2
  target_1 := "" . file . t_rank_1 . ""
  target_2 := "" . file . t_rank_2 . ""
  t1_stat := SqStat(target_1)  ;SqStat()--SquareStatus()
  t2_stat := SqStat(target_2)
  if (t2_stat = "empty" AND t1_stat = "empty") {
    return target_2
  } else if (t1_stat = "empty") {
    return target_1
  } else {
    return
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


FindJumps(spot) {
  rank := board[spot].rank
  col := board[spot].column

  jump_1_rank := rank + 1
  jump_1_col := col - 1
  jump_1_file := Chr(96 + jump_1_col)
  jump_1_spot := "" . jump_1_file . jump_1_rank . ""

  jump_2_rank := rank + 1
  jump_2_col := col + 1
  jump_2_file := Chr(96 + jump_2_col)
  jump_2_spot := "" . jump_2_file . jump_2_rank . ""

;  MsgBox, % "jump_1: " . jump_1_spot . "  jump_2: " . jump_2_spot . ""

  return [jump_1_spot, jump_2_spot]
}

