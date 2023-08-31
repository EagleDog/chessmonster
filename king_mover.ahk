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


;MoveKing("c1")
MoveKing(spot) {

  ; check for castle option
  castle := false

  moves := FindKMoves(spot)
;  OutputKMoves(moves)

  target := KingCapture(moves)
  if target {

    MovePiece(spot, target)
  } else {

    target := KingMoveEmpty(moves)
    if target {

      MovePiece(spot, target)
    }
  }
}

FindKMoves(spot) {
  m1 := spot
  m2 := spot
  m3 := spot
  m4 := spot
  m5 := spot
  m6 := spot
  m7 := spot
  m8 := spot
  moves := [m1, m2, m3, m4, m5, m6, m7, m8]
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


FindKMoves(spot) {         ; Find 8 King Moves
  col := board[spot].col
  row := board[spot].row

  moves := {}


  ; .... This is where I'm working right now.....



  while (row < 8) {
    n := A_Index
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    moves[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return m1
    }
  }
  return m1
}


FindKMove1() {
  return
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






