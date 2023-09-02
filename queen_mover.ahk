;queen_mover.ahk
;
; path_1 - up
; path_2 - right
; path_3 - down
; path_4 - left
; path_5 - up / left
; path_6 - up / right
; path_7 - down / right
; path_8 - down / left
;
; STEP 1 - explore 8 paths
; STEP 2 - end blocked paths (wall or collistion)
; STEP 3 - attack opponents
; STEP 4 - move to empty square


;MoveQueen("c1")
MoveQueen(spot) {
  paths := FindQPaths(spot)
;  OutputQPaths(paths)
  target := QueenCapture(paths)
  if target {
    MovePiece(spot, target)
  } else {
    target := QueenMoveEmpty(paths)
    if target {
      MovePiece(spot, target)
    }
  }
}

FindQPaths(spot) {
  p1 := FindQPath1(spot)
  p2 := FindQPath2(spot)
  p3 := FindQPath3(spot)
  p4 := FindQPath4(spot)
  p5 := FindQPath5(spot)
  p6 := FindQPath6(spot)
  p7 := FindQPath7(spot)
  p8 := FindQPath8(spot)
  paths := [p1, p2, p3, p4, p5, p6, p7, p8]
  return paths
}

QueenCapture(paths) {    ; QUEEN CAPTURE OPPONENT
  n := 1
  while paths[n] {
    nn := 1
    while paths[n][nn] {
      if (paths[n][nn].color = opp_color) {
        if RandomChoice() {                   ; randomize 1:2 odds takes piece
          return paths[n][nn].spot
        }
      }
      nn += 1
    }
    n += 1
  }
}

QueenMoveEmpty(paths) {    ; QUEEN MOVE TO EMPTY SQUARE
  n := 1
  poss_paths := []
  while paths[n] {
    nn := 1
    while paths[n][nn] {
      if (paths[n][nn].color = "empty") {
        poss_paths.push(paths[n][nn])          ; randomize
      }
      nn += 1
    }
    n += 1
  }
  num_options := poss_paths.length()
  random, which_option, 1, num_options         ; randomize randomize randomize randomize randomize
  return poss_paths[which_option].spot
}


FindQPath1(spot) {         ; PATH 1   STRAIGHT   UP
  col := board[spot].col
  row := board[spot].row
  p1 := {}
  while (row < 8) {
    n := A_Index
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p1
    }
  }
  return p1
}

FindQPath2(spot) {         ; PATH 2   STRAIGHT   RIGHT
  col := board[spot].col
  row := board[spot].row
  p2 := {}
  while (col < 8) {
    n := A_Index
    col += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p2[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p2
    }
  }
  return p2
}

FindQPath3(spot) {         ; PATH 3   STRAIGHT    DOWN
  col := board[spot].col
  row := board[spot].row
  p3 := {}
  while (row > 1) {
    n := A_Index
    row -= 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p3[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p3
    }
  }
  return p3
}

FindQPath4(spot) {         ; PATH 4   STRAIGHT   LEFT
  col := board[spot].col
  row := board[spot].row
  p4 := {}
  while (col > 1) {
    n := A_Index
    col -= 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p4[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p4
    }
  }
  return p4
}


FindQPath5(spot) {             ; PATH 5  DIAG   UP/LEFT
  col := board[spot].col
  row := board[spot].row
  p5 := {}
  while ( (col > 1) and (row < 8) ) {
    n := A_Index
    col -= 1
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p5
    }
  }
  return p5
}

FindQPath6(spot) {             ; PATH 6  DIAG  UP/RIGHT
  col := board[spot].col
  row := board[spot].row
  p6 := {}
  while ( (col < 8) and (row < 8) ) {
    n := A_Index
    col += 1
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p2[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p6
    }
  }
  return p6
}

FindQPath7(spot) {             ; PATH 7  DIAG   DOWN/RIGHT
  col := board[spot].col
  row := board[spot].row
  p7 := {}
  while ( (col < 8) and (row > 1) ) {
    n := A_Index
    col += 1
    row -= 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p3[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p7
    }
  }
  return p7
}

FindQPath8(spot) {             ; PATH 8   DIAG  DOWN/LEFT
  col := board[spot].col
  row := board[spot].row
  p8 := {}
  while ( (col > 1) and (row > 1) ) {
    n := A_Index
    col -= 1
    row -= 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    MouseMove, board[spot].x, board[spot].y
    p4[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    Sleep, 10
    if (color = my_color) {   ; collision same color
      return p8
    }
  }
  return p8
}

OutputQPaths(paths) {
  n := 1
  spot_text := ""
  path_text := ""
  while paths[n] {
    nn := 1
    while paths[n][nn] {
      spot_text := paths[n][nn].spot . " " paths[n][nn].color . " | "
      path_text := path_text . spot_text
    nn += 1
    }
  n += 1
  }
  MsgBox, % path_text
}






