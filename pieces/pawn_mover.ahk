;pawn_moves.ahk
;
; PawnMoves(spot)
; MovePawn1(spot)
; MovePawn2(spot)
; MovePawn3(spot)
;
;

MovePawn(spot) {
  LogCenter("MovePawn('" . spot . "')")
  if ( RandomChoice(3) ) {  ; reduce pawn move frequency
    return
  }
  diags := FindDiags(spot)   ; array
  target := PawnAttack(diags)  ; diag attacks
  if target {
    return target
  } else if (b[spot].rank = 2) {
    target := MovePawn2(spot) 
    if target {
      return target
    }  
  } else {
    target := MovePawn3(spot)
    if target {
      return target
    }
  }
}

PawnAttack(diags) {  ; Diagonal Attack
;  diags := FindDiags(spot) ;array
  diag_1 := diags[1] ;spot
  diag_2 := diags[2] ;spot
  ; diag_1_status := SquareStatus(diag_1)
  ; diag_2_status := SquareStatus(diag_2)
  if (SqStat(diag_1) = opp_color) {
    return diag_1
  } else if (SqStat(diag_2) = opp_color) {
    return diag_2
  } else {
    return
  }
}

MovePawn2(spot) {  ; Forward Two Squares
  file := b[spot].file  ; b-board
  t_rank_1 := b[spot].rank + 1  ; t-target
  t_rank_2 := b[spot].rank + 2
  target_1 := "" . file . t_rank_1 . ""
  target_2 := "" . file . t_rank_2 . ""
  t1_stat := SqStat(target_1)  ;SqStat()--SquareStatus()
  t2_stat := SqStat(target_2)
  if (t1_stat = "empty") {
    Random, rand_choice, 1, 2   ; randomize randomize randomize randomize
    if (rand_choice = 1) {
      return target_1
    } else if (t2_stat = "empty") {
      return target_2
    } else {
      return
    }
  }
}
;   if (t2_stat = "empty" AND t1_stat = "empty") {
;     return target_2
;   } else if (t1_stat = "empty") {
;     return target_1
;   } else {
;     return
;   }
; }

MovePawn3(spot) {  ; Forward One Square
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


FindDiags(spot) {
  rank := board[spot].rank
  col := board[spot].col

  diag_1_rank := rank + 1
  diag_1_col := col - 1
  diag_1_file := Chr(96 + diag_1_col)
  diag_1_spot := "" . diag_1_file . diag_1_rank . ""

  diag_2_rank := rank + 1
  diag_2_col := col + 1
  diag_2_file := Chr(96 + diag_2_col)
  diag_2_spot := "" . diag_2_file . diag_2_rank . ""

;  MsgBox, % "diag_1: " . diag_1_spot . "  diag_2: " . diag_2_spot . ""

  return [diag_1_spot, diag_2_spot]
}

