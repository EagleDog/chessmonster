;rook_mover.ahk
;
; path_1 - up
; path_2 - right
; path_3 - down
; path_4 - left
;
; STEP 1 - explore 4 paths
; STEP 2 - end blocked paths (wall or collistion)
; STEP 3 - attack opponents
; STEP 4 - move to empty square


;MoveRook("c1")
MoveRook(spot) {
  LogMain("MoveRook('" . spot . "')")
  paths := FindRPaths(spot)
  ; OutputRPaths(paths)
  target := RookCapture(paths)
  if target {
    MovePiece(spot, target)
  } else {
    target := RMoveEmpty(paths)
    if target {
      return target
;      MovePiece(spot, target)
    }
  }
}

RMoveEmpty(paths) {    ; ROOK MOVE TO EMPTY SQUARE
  n := 1
  poss_paths := []
  while paths[n] {
    nn := 1
    while paths[n][nn] {
      if (paths[n][nn].color = "empty") {
        poss_paths.push(paths[n][nn])      ; randomize randomize
      }
      nn += 1
    }
    n += 1
  }
  num_options := poss_paths.length()
  random, which_option, 1, num_options         ; randomize randomize randomize randomize randomize
  return poss_paths[which_option].spot
}

RookCapture(paths) {    ; ROOK CAPTURE OPPONENT
  n := 1
  while paths[n] {
    nn := 1
    while paths[n][nn] {
      if (paths[n][nn].color = opp_color) {
        return paths[n][nn].spot
      }
      nn += 1
    }
    n += 1
  }
}

FindRPaths(spot) {
  p1 := FindRPath1(spot)
  p2 := FindRPath2(spot)
  p3 := FindRPath3(spot)
  p4 := FindRPath4(spot)
  paths := [p1, p2, p3, p4]
  return paths
}

FindRPath1(spot) {         ; ROOK PATH 1 UP
  col := board[spot].col
  row := board[spot].row
  p1 := {}
  while (row < 8) {
    n := A_Index
    row += 1
    rank := row
    file := ColToFile(col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; collision same color
      return p1
    }
  }
  return p1
}

FindRPath2(spot) {         ; ROOK PATH 2 RIGHT
  col := board[spot].col
  row := board[spot].row
  p2 := {}
  while (col < 8) {
    n := A_Index
    col += 1
    rank := row
    file := ColToFile(col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p2[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; collision same color
      return p2
    }
  }
  return p2
}

FindRPath3(spot) {         ; ROOK PATH 3 DOWN
  col := board[spot].col
  row := board[spot].row
  p3 := {}
  while (row > 1) {
    n := A_Index
    row -= 1
    rank := row
    file := ColToFile(col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p3[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; collision same color
      return p3
    }
  }
  return p3
}

FindRPath4(spot) {         ; ROOK PATH 4 LEFT
  col := board[spot].col
  row := board[spot].row
  p4 := {}
  while (col > 1) {
    n := A_Index
    col -= 1
    rank := row
    file := ColToFile(col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p4[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; collision same color
      return p4
    }
  }
  return p4
}


OutputRPath(paths) {
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



