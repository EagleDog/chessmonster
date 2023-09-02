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


; known problem: white king often evades detection, 
;          especially on f file.


; doing good. let's randomize move decisions........



MoveKing(spot) {
  ; check for castle option
  castle := false                                 ;         CASTLE
  diffs := FindKDiffs(spot)                       ;          DIFFS
  poss_moves := PossKMoves(spot, diffs) ; 8 moves possible     POSSKMOVES
  moves := KingMoves(poss_moves)    ; eliminate walls and collisions   KINGMOVES
;  OutputKMoves(moves)
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
;  MsgBox, % diffs[1][1]
  return diffs
}

PossKMoves(spot, diffs) {       ; 8 Possible King Moves
  col := board[spot].col          ;   based on diffs
  row := board[spot].row
  file := Chr(96 + col)
  rank := row
  poss_moves := {}
;  MsgBox, % diffs[1][1]
;  MsgBox, Begin PossKMoves
  Loop, 8 {
    n := A_Index
    m_col := col + diffs[n][1]     ; 1,1... 1,2... 2,1... 2,2... 3,1... 3,2...
    m_file := Chr(96 + m_col)
    m_row := row + diffs[n][2]
    m_rank := m_row
    m_spot := m_file . m_rank
    m_color := SqStat(m_spot)
    Sleep, 10
    MouseMove, board[m_spot].x, board[m_spot].y
    poss_moves[n] := { col: m_col, row: m_row, file: m_file, rank: m_rank, spot: m_spot, color: m_color }
    Sleep, 10
  }
  return poss_moves
}

KingMoves(poss_moves) {         ; eliminate collisions and out-of-bounds
  moves := poss_moves
  loop, 8 {
    n := A_Index
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
  loop, 8 {
    n := A_Index
    if (moves[n]) {
      if ( (moves[n].color = opp_color) AND (RandomChoice()) ) {    ; 1:2 odds randomized
        return moves[n].spot
      }
    }
  }
}

KingMoveEmpty(moves) {    ; KING MOVE TO EMPTY SQUARE
  n := 1
  loop, 8 {
    n := A_Index
    Random, n, 1, 8    ; begin random move effort randomization
    if (moves[n]) {
      if (moves[n].color = "empty") {
        return moves[n].spot
      }
    }
  }
}

OutputKMoves(moves) {
  n := 1
  spot_text := ""
  move_text := ""
  loop, 8 {
    n := A_Index
    spot_text := moves[n].spot . " " moves[n].color . " | "
    move_text := move_text . spot_text
  }
  MsgBox, % move_text
}



