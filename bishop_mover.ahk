;bishop_mover.ahk
;
; p1.1 - up, left
; p2.1 - up, right
; p3.1 - down, right
; p4.1 - down, left
;
; STEP 1 - explore 4 paths
; STEP 2 - end blocked paths (wall or collistion)
; STEP 3 - attack opponents
; STEP 4 - mvoe to empty square

#Include chessmonster.ahk
; #Include board_map.ahk
; #Include board_watcher.ahk

my_color := "white"

;MoveBishop("c1")
MoveBishop(spot) {
  p1 := {}
  p2 := {}
  p3 := {}
  p4 := {}
  paths := [p1, p2, p3, p4]
  p1 := FindPaths(spot)
  OutputPath(p1)
  return
}

FindPaths(spot) {
  ; path 1 is all possible moves up, left, until wall
  col := board[spot].col
  row := board[spot].row
  p1 := {}
  ; p2 := {}
  ; p3 := {}
  ; p4 := {}

  ; PATH 1
  while ( (col > 1) and (row < 8) ) {
    n := A_Index
    col -= 1
    row += 1
    rank := row
    file := Chr(96 + col)
    spot := file . rank
    color := SqStat(spot)
    ;p1[n] := { col, row, file, rank, spot, color }
    p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
;    MsgBox, % " info: " . p1[n].file
    ; if (color = my_color) {
    ;   MsgBox, "blocked"
    ;   return "blocked"
    ; }
  }
  return p1
}


  OutputPath(path) {
  n := 1
  spot_text := ""
  path_text := ""
  msg_text := path[n].spot
;  MsgBox, % msg_text
  while path[n] {
    n := A_Index
    spot_text := path[n].spot . " " path[n].color . " | "
;    MsgBox, % spot_text
    path_text := path_text . spot_text
;    MsgBox, % path_text
  }
  MsgBox, % path_text
}


0::MoveBishop("c1")







  ; ; PATH 2
  ; while ( (col < 8) and (row < 8) ) {
  ;   n := A_Index
  ;   col += 1
  ;   row += 1
  ;   file := Chr(96 + col)
  ;   spot := file . rank
  ;   color := SqStat(dspot)
  ;   ;p1[n] := { col, row, file, rank, spot, color }
  ;   p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
  ;   if (color := my_color) {
  ;     MsgBox, "blocked"
  ;     return "blocked"
  ;   }
  ; }

  ; ; PATH 3
  ; while ( (col < 8) and (row > 1) ) {
  ;   n := A_Index
  ;   col += 1
  ;   row -= 1
  ;   file := Chr(96 + col)
  ;   spot := file . rank
  ;   color := SqStat(dspot)
  ;   ;p1[n] := { col, row, file, rank, spot, color }
  ;   p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
  ;   if (color := my_color) {
  ;     MsgBox, "blocked"
  ;     return "blocked"
  ;   }
  ; }

  ; ; PATH 4
  ; while ( (col > 1) and (row > 1) ) {
  ;   n := A_Index
  ;   col -= 1
  ;   row -= 1
  ;   file := Chr(96 + col)
  ;   spot := file . rank
  ;   color := SqStat(dspot)
  ;   ;p1[n] := { col, row, file, rank, spot, color }
  ;   p1[n] := { col: col, row: row, file: file, rank: row, spot: spot, color: color }
  ;   if (color := my_color) {
  ;     MsgBox, "blocked"
  ;     return "blocked"
  ;   }
  ; }
; }



;^+x::Exit



  ; diags["d1"] := { col: col - 1, rank: rank + 2, file: Chr(96 + col - 1), spot: Chr(96 + col - 1) . rank + 2, color: SqStat(dspot) }
  ; diags["d2"] := { col: col + 1, rank: rank + 2, file: Chr(96 + col + 1), spot: Chr(96 + col + 1) . rank + 2, color: SqStat(dspot) }
  ; diags["d3"] := { col: col + 2, rank: rank + 1, file: Chr(96 + col + 2), spot: Chr(96 + col + 2) . rank + 1, color: SqStat(dspot) }
  ; diags["d4"] := { col: col + 2, rank: rank - 1, file: Chr(96 + col + 2), spot: Chr(96 + col + 2) . rank - 1, color: SqStat(dspot) }
  ; diags["d5"] := { col: col + 1, rank: rank - 2, file: Chr(96 + col + 1), spot: Chr(96 + col + 1) . rank - 2, color: SqStat(dspot) }
  ; diags["d6"] := { col: col - 1, rank: rank - 2, file: Chr(96 + col - 1), spot: Chr(96 + col - 1) . rank - 2, color: SqStat(dspot) }
  ; diags["d7"] := { col: col - 2, rank: rank - 1, file: Chr(96 + col - 2), spot: Chr(96 + col - 2) . rank - 1, color: SqStat(dspot) }
  ; diags["d8"] := { col: col - 2, rank: rank + 1, file: Chr(96 + col - 2), spot: Chr(96 + col - 2) . rank + 1, color: SqStat(dspot) }

; FindDBounds(spot) {
;   col := board[spot].col
;   rank := board.[spot].rank

;   dbounds := []
;   return dbounds
; }





