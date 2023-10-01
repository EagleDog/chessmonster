;bishop_mover.ahk
;
; path_1 - up, left
; path_2 - up, right
; path_3 - down, right
; path_4 - down, left
;
; STEP 1 - explore 4 paths
; STEP 2 - end blocked paths (wall or collistion)
; STEP 3 - attack opponents
; STEP 4 - move to empty square



;MoveBishop("c1")
MoveBishop(spot) {
  LogCenter("MoveBishop('" . spot . "')")
  paths := FindDPaths(spot)
  ; OutputDPath(paths[1])
  ; OutputDPath(paths[2])
  ; OutputDPath(paths[3])
  ; OutputDPath(paths[4])
  target := DiagCapture(paths)
  if target {
    MovePiece(spot, target)
  } else {
    target := DMoveEmpty(paths)
    if target {
      return target
;      MovePiece(spot, target)
    }
  }
}

DMoveEmpty(paths) {    ; DIAG MOVE TO EMPTY SQUARE
  n := 1
  poss_diags := []
  while paths[n] {
    nn := 1
    while paths[n][nn] {
      if (paths[n][nn].color = "empty") {
        poss_diags.push(paths[n][nn])      ; randomize randomize
      }
      nn += 1
    }
    n += 1
  }
  num_options := poss_diags.length()
  random, which_option, 1, num_options         ; randomize randomize randomize randomize randomize
  return poss_diags[which_option].spot
}

DiagCapture(paths) {    ; DIAG CAPTURE OPPONENT
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

FindDPaths(spot) {
  p1 := FindDPath1(spot)
  p2 := FindDPath2(spot)
  p3 := FindDPath3(spot)
  p4 := FindDPath4(spot)
  paths := [p1, p2, p3, p4]
  return paths
}

FindDPath1(spot) {             ; DIAG PATH 1
  col := board[spot].col
  row := board[spot].row
  p1 := {}

  while ( (col > 1) and (row < 8) ) {
    n := A_Index
    col -= 1
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; COLLISION SAME COLOR
      return p1
    }
  }
  return p1
}

FindDPath2(spot) {             ; DIAG PATH 2
  col := board[spot].col
  row := board[spot].row
  p2 := {}
  while ( (col < 8) and (row < 8) ) {
    n := A_Index
    col += 1
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p2[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {     ; COLLISION SAME COLOR
      return p2
    }
  }
  return p2
}

FindDPath3(spot) {             ; DIAG PATH 3
  col := board[spot].col
  row := board[spot].row
  p3 := {}

  while ( (col < 8) and (row > 1) ) {
    n := A_Index
    col += 1
    row -= 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p3[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; COLLISION SAME COLOR
      return p3
    }
  }
  return p3
}

FindDPath4(spot) {             ; DIAG PATH 4
  col := board[spot].col
  row := board[spot].row
  p4 := {}

  while ( (col > 1) and (row > 1) ) {
    n := A_Index
    col -= 1
    row -= 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    p4[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
    if (color = my_color) {   ; COLLISION SAME COLOR
      return p4
    }
  }
  return p4
}


OutputDPath(path) {
  n := 1
  spot_text := ""
  path_text := ""
  while path[n] {
    n := A_Index
 
    spot_text := path[n].spot . " " path[n].color . " | "
    path_text := path_text . spot_text
  }
  MsgBox, % path_text
}


