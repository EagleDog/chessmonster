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


;KnightMoves("b1")
MoveKnight(spot) {
;  MsgBox, KnightMoves......
;  jumps := FindJumps(spot)    ;[j1,j2,j3,j4,j5,j6,j7,j8]
  jumps := FindJumps(spot)    ;{j1.col,j1.rank,j2.col,j2.rank,j3.col,j3.rank}
  jbounds := FindJBounds(jumps)  ;[0,1,0,0,1,1,0,0]
;  MsgBox, % jbounds[7]
  best_jump := FindJMoves(jumps, jbounds)

  if best_jump {
    MsgBox, % "Best jump: " . best_jump . ""
    return best_jump
  } else {
    best_jump := FindJEmpties(jumps, jbounds)
    if best_jump {
      MsgBox, % "Best jump: " . best_jump . ""
      return best_jump
    } else {
      MsgBox, No move available.
    }
  }
}


; STEP 1
FindJumps(spot) {
  rank := board[spot].rank
  col := board[spot].column
;  source := [col, rank]
  jumps := {}

  jcol := col - 1
  jrank := rank + 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j1"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 1
  jrank := rank + 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j2"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 2
  jrank := rank + 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j3"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 2
  jrank := rank - 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j4"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 1
  jrank := rank - 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j5"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col - 1
  jrank := rank - 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j6"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col - 2
  jrank := rank - 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j7"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col - 2
  jrank := rank + 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
;  MsgBox, % jspot
  jumps["j8"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}


  ; jumps["j1"] := { col: col - 1, rank: rank + 2, file: Chr(96 + col - 1), spot: Chr(96 + col - 1) . rank + 2}
  ; jumps["j2"] := { col: col + 1, rank: rank + 2, file: Chr(96 + col + 1), spot: 1}
  ; jumps["j3"] := { col: col + 2, rank: rank + 1, file: Chr(96 + col + 2), spot: 1}
  ; jumps["j4"] := { col: col + 2, rank: rank - 1, file: Chr(96 + col + 2), spot: 1}
  ; jumps["j5"] := { col: col + 1, rank: rank - 2, file: Chr(96 + col + 1), spot: 1}
  ; jumps["j6"] := { col: col - 1, rank: rank - 2, file: Chr(96 + col - 1), spot: 1}
  ; jumps["j7"] := { col: col - 2, rank: rank - 1, file: Chr(96 + col - 2), spot: 1}
  ; jumps["j8"] := { col: col - 2, rank: rank + 1, file: Chr(96 + col - 2), spot: 1}

;  MsgBox, % jumps["j4"].file

;  jumps := [j1, j2, j3, j4, j5, j6, j7, j8]
;  jumps := {j1:j2,j2:j2,j3:j3,j4:j4,j5:j5,j6:j6,j7:j7,j8:j8}

;  jumps[j1] := 

  ; jump_2_rank := rank + 1
  ; jump_2_col := col + 1
  ; jump_2_file := Chr(96 + jump_2_col)
  ; jump_2_spot := "" . jump_2_file . jump_2_rank . ""

;  MsgBox, % "jump_1: " . jump_1_spot . "  jump_2: " . jump_2_spot . ""

  return jumps ;{j1.col,j1.rank,j2.col,j2.rank,j3.col,j3.rank}
}


; STEP 2
FindJBounds(jumps) {
;  jumps := FindJumps(spot) ;[j1,j2,j3,j4,j5,j6,j7,j8]
  ;check boardbounds for target squares
  ; out-of-bounds < 1 or > 8
  ;   0 < bounds < 9
;  MsgBox, % "" . jumps[1] . " " . jumps[1][1] . " " . jumps[1][2] . " " . jumps[1].1 . ""
;  MsgBox, % "" jumps[1].1 . ""


  jbounds := [1,1,1,1,1,1,1,1]
  jkeys := ["j1","j2","j3","j4","j5","j6","j7","j8"]
  Loop, 8 {
    n := A_Index

;    msg_text := jkeys[n]
;    msg_text := jumps[jkeys.n]
;    MsgBox, % msg_text
;    MsgBox, % jumps[jkeys[n]].col
    jspot := jumps[jkeys[n]].spot
    jcolor := jumps[jkeys[n]].color

    MsgBox, % jspot . jcolor
;    MsgBox, % jcolor


    if ( ( jumps[jkeys[n]].col < 1 )
        or ( jumps[jkeys[n]].col > 8 )
        or ( jumps[jkeys[n]].rank < 1 )
        or ( jumps[jkeys[n]].rank > 8 ) ) {
      jbounds[n] := 0
    }
  }
;  MsgBox, % "" . jbounds[1] . jbounds[2] . jbounds[7] . jbounds[8] . ""
  return jbounds  ;[0,0,1,0,1,1,0,1]
}   ; end FindJBounds(spot, jumps)


    ; n := A_Index
    ; Loop, 2 {
    ;   nn := A_Index    ;[1,1] [1,2] [2,1] [2,2] [3,1] [3,2]
    ;   if ( (jumps[n][nn] < 1) OR (jumps[n][nn] > 8) ) {
    ;     jbounds[n] := 0
    ;   }



; STEP 3
FindJMoves(jumps, jbounds) {
  jkeys := ["j1","j2","j3","j4","j5","j6","j7","j8"]
  b_msg := ""
  Loop, 8 {
    n := A_Index
;    MsgBox, % jbounds[n]

    key := jkeys[n]
    jspot := jumps[key].spot
    jcolor := jumps[key].color

    if jbounds[n] {
      if ( jcolor = my_color ) {  ; COLLISION CHECK
;        MsgBox, % jspot . " " . jcolor
        jbounds[n] := 0
      } else if ( jcolor = opp_color ) {
        return jspot
      }
    }
    b_msg := b_msg . jbounds[n]
  }
  MsgBox, % b_msg
}

;      MsgBox, % jbounds[n]
;      MsgBox, % jspot
;      MsgBox % target_color

    ; if (jbounds[n] = 1) {
    ;   file := Chr(96 + jumps[n][1])  ; column > a-h
    ;   rank := jumps[n][2]
    ;   spot := file . rank



;STEP 3.5 COLLISION CHECKS
FindJEmpties(jumps, jbounds) {
  jkeys := ["j1","j2","j3","j4","j5","j6","j7","j8"]
  Loop, 8 {
    n := A_Index
    key := jkeys[n]
    jspot := jumps[key].spot
    MsgBox, % jbounds[n]
    if jbounds[n] {
      return jspot
    }
  }
}



; MoveKnight3(spot) {  ; Forward One Square
;   file := b[spot].file
;   t_rank := b[spot].rank + 1
;   target := "" . file . t_rank . ""
; ;  MsgBox, %target%
;   if SqStat(target) = "empty" {
;     return target
;   } else {
;     return
;   }
; }



