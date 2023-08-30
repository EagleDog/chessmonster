;knight_mover.ahk
;
; MoveKnight(spot)
; FindJumps(spot)     STEP 1
; FindJBounds(jumps)    STEP 2
; FindJMoves(jumps, jbounds)  STEP 3
; FindJEmpties(jumps, jbounds)  STEP 4
;
; STEP 1 -- find 8 possible jumps (target squares)
; STEP 1 -- eliminate out-of-board jumps
; STEP 3 -- attack opponents; eliminate collisions
; STEP 4 -- move to empty square

MoveKnight(spot) {  ;MoveKnight("b1")
  jumps := FindJumps(spot)   ;{j1.col,j1.rank,j1.spot,j1.color,j2.col,j2.rank,j3.col,j3.rank}
  jbounds := FindJBounds(jumps)  ;[0,1,0,0,1,1,0,0]
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
  jumps := {}

  jcol := col - 1
  jrank := rank + 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j1"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 1
  jrank := rank + 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j2"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 2
  jrank := rank + 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j3"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 2
  jrank := rank - 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j4"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col + 1
  jrank := rank - 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j5"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col - 1
  jrank := rank - 2
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j6"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col - 2
  jrank := rank - 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j7"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}
  jcol := col - 2
  jrank := rank + 1
  jfile := chr(96 + jcol)
  jspot := jfile . jrank
  jcolor := SqStat(jspot)
  jumps["j8"] := { col: jcol, rank: jrank, file: jfile, spot: jspot, color: jcolor}

  ; jumps["j1"] := { col: col - 1, rank: rank + 2, file: Chr(96 + col - 1), spot: Chr(96 + col - 1) . rank + 2}
  ; jumps["j2"] := { col: col + 1, rank: rank + 2, file: Chr(96 + col + 1), spot: 1}
  ; jumps["j3"] := { col: col + 2, rank: rank + 1, file: Chr(96 + col + 2), spot: 1}
  ; jumps["j4"] := { col: col + 2, rank: rank - 1, file: Chr(96 + col + 2), spot: 1}
  ; jumps["j5"] := { col: col + 1, rank: rank - 2, file: Chr(96 + col + 1), spot: 1}
  ; jumps["j6"] := { col: col - 1, rank: rank - 2, file: Chr(96 + col - 1), spot: 1}
  ; jumps["j7"] := { col: col - 2, rank: rank - 1, file: Chr(96 + col - 2), spot: 1}
  ; jumps["j8"] := { col: col - 2, rank: rank + 1, file: Chr(96 + col - 2), spot: 1}

  return jumps ;{j1.col,j1.rank,j1.spot,j1.color,j2.col,j2.rank,j3.col,j3.rank}
}


; STEP 2
FindJBounds(jumps) {  ; out-of-bounds < 1 or > 8
  jbounds := [1,1,1,1,1,1,1,1]
  jkeys := ["j1","j2","j3","j4","j5","j6","j7","j8"]
  Loop, 8 {
    n := A_Index
    jspot := jumps[jkeys[n]].spot
    jcolor := jumps[jkeys[n]].color
    if ( ( jumps[jkeys[n]].col < 1 )
        or ( jumps[jkeys[n]].col > 8 )
        or ( jumps[jkeys[n]].rank < 1 )
        or ( jumps[jkeys[n]].rank > 8 ) ) {
      jbounds[n] := 0
    }
  }
  return jbounds  ;[0,0,1,0,1,1,0,1]
}


; STEP 3
FindJMoves(jumps, jbounds) {
  jkeys := ["j1","j2","j3","j4","j5","j6","j7","j8"]
;  b_msg := ""
  Loop, 8 {
    n := A_Index
    key := jkeys[n]
    jspot := jumps[key].spot
    jcolor := jumps[key].color

    if jbounds[n] {
      if ( jcolor = my_color ) {  ; COLLISION CHECK
        jbounds[n] := 0
      } else if ( jcolor = opp_color ) {
        return jspot    ; ATTACK OPPONENT
      }
    }
;    b_msg := b_msg . jbounds[n]
  }
;  MsgBox, % b_msg
}


;STEP 4 -- JUMP TO EMPTY SQUARE
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


