;king_mover.ahk
;
; move_1 - up
; move_2 - right
; move_3 - down
; move_4 - left
; move_5 - up / left
; move_6 - up / right
; move_7 - down / right
; move_8 - down / left
;
; STEP 1 - can I castle?
; STEP 2 - find 8 possible moves
; STEP 3 - eliminate blocked moves (wall or collision)
; STEP 4 - attack opponents
; STEP 5 - move to empty square






MoveKing(spot) {
  ; check for castle option
  castle := false                                 ;         CASTLE
  diffs := FindKDiffs(spot)                       ;          DIFFS
  poss_moves := PossKMoves(spot, diff) ; 8 moves possible     POSSKMOVES
  moves := KingMoves(poss_moves)    ; eliminate walls and collisions   KINGMOVES
  ; OutputKMoves(moves)
  target := KingCapture(moves)      ; KingCapture(moves)   CAPTURE
  if target {
    MovePiece(spot, target)
  } else {

    target := KingMoveEmpty(moves)    ; KnigMoveEmpty(moves)   EMPTY
    if target {

      MovePiece(spot, target)
    }
  }
}

FindKDiffs(spot) {               ; Find 8 King Diffs          DIFFS
  m1 := [  0,  1 ]
  m2 := [  1,  1 ]
  m3 := [  1,  0 ]
  m4 := [  1, -1 ]
  m5 := [  0, -1 ]
  m6 := [ -1, -1 ]
  m7 := [ -1,  0 ]
  m8 := [ -1,  1 ]
  diffs := [m1, m2, m3, m4, m5, m6, m7, m8]
  return diffs
}

PossKMoves(spot, diffs) {       ; 8 Possible King Moves
  col := board[spot].col          ;   based on diffs
  row := board[spot].row
  file := Chr(96 + col)
  rank := row
  poss_moves := {}

  Loop, 8 {                       ;   n ~ x
    n := A_Index
    col += diffs[n][1]     ; 1,1... 1,2... 2,1... 2,2... 3,1... 3,2...
    file := Chr(96 + col)
    row += diffs[n][2]
    rank := row
    spot := file . rank
    color := SqStat(spot)
    Sleep, 10
    MouseMove, board[spot].x, board[spot].y
    poss_moves[n] := { col: col, row: row, file: file, rank: rank, spot: spot, color: color }
    Sleep, 10
    ; if (color = my_color) {     ; collision same color
      ; ...
  }
  return poss_moves
}

KingMoves(poss_moves) {         ; eliminate collisions and out-of-bounds
  loop, 8 {
    n := A_Index
    moves := poss_moves
    this_move := moves[n]
    if ( (this_move.color = my_color) OR (this_move.col < 1)
        OR (this_move.row < 1) OR (this_move.col > 8) 
        OR (this_move.row > 8) ) {
      this_move := ""
    }
  }
  return moves
}

KingCapture(moves) {    ; KING CAPTURE OPPONENT
  n := 1
  while moves[n] {
    nn := 1
    while moves[n][nn] {
      if (moves[n][nn].color = opp_color) {
        return moves[n][nn].spot
      }
      nn += 1
    }
    n += 1
  }
}

KingMoveEmpty(moves) {    ; KING MOVE TO EMPTY SQUARE
  n := 1
  while moves[n] {
    nn := 1
    while moves[n][nn] {
      if (moves[n][nn].color = "empty") {
        return moves[n][nn].spot
      }
      nn += 1
    }
    n += 1
  }
}


OutputKMoves(moves) {
  n := 1
  spot_text := ""
  move_text := ""
  while moves[n] {
    nn := 1
    while moves[n][nn] {
      spot_text := moves[n][nn].spot . " " moves[n][nn].color . " | "
      move_text := move_text . spot_text
    nn += 1
    }
  n += 1
  }
  MsgBox, % move_text
}



