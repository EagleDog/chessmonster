;piece_polls.ahk
; HowManyPieces()


global last_spot := "a6"
global last_piece := "empty"
global prev_opp_pieces_spots := {}


DoNothing() {
  nothing := "nothing"
  return nothing
}

WhichPoll(last_spot) {
  prev_opp_pieces_spots := PrevOppPiecesSpots() ; array[]
  last_spot := last_spot ;"e5" ;last_spot  ; global var e.g. "a6"
  last_piece := last_piece  ; global var e.g. "empty"
  switch last_piece {
    case "empty":
      DoNothing()
      return "empty"
    case "pawn":
      CheckPawnPositions(last_spot) ,  return "pawn"
    case "knight":
      CheckKnightPositions(last_spot) ,  return "knight"
    case "bishop":
      CheckBishopPositions(last_spot) ,  return "bishop"
    case "rook":
      CheckRookPositions(last_spot) ,  return "rook"
    case "queen":
      CheckQueenPositions(last_spot) ,  return "queen"
    case "king":
      CheckKingPositions(last_spot) ,  return "king"
  }
}

CheckPawnPositions(spot) {
  msgbox % spot . " " . last_spot . " :  last spot "
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag_2 := [ -1, 1 ]
  sources := [ back_one, back_two, back_diag_1, back_diag_2 ]
  position := CheckSpot(spot)
  spot := position.spot
  col := position.col
  rank := position.rank
  n := 1
  GoSpot(spot)

  while sources[n] {
    n := A_Index
    if !n {
      return
    }
    col += sources[n][1]
    rank += sources[n][2]
    file := FindFile(col)
    spot := file . rank
    msgbox % spot . "     "
  }
}

CheckSpot(spot) {
  position := PollPosition(spot)
  GoSpot(spot)
  ; MoveMouse(position.x, position.y)
  return position
}

PrevOppPiecesSpots() {
  opp_knights := []  ; ["b8", "g8"]
  opp_bishops := []  ; ["c8", "f8"]
  opp_rooks := []
  opp_queens := []
  opp_kings := []
  opp_pieces_spots := {}
  prev_positions := prev_positions ; global {} variable

  loop, 64 {
    n := A_Index
    spot := all_spots[n]   ; all_spots is global array
    if        (prev_positions[spot].piece == "knight") {
      opp_knights.push(spot)
    } else if (prev_positions[spot].piece == "bishop") {
      opp_bishops.push(spot)
    } else if (prev_positions[spot].piece == "rook") {
      opp_bishops.push(spot)
    } else if (prev_positions[spot].piece == "queen") {
      opp_bishops.push(spot)
    } else if (prev_positions[spot].piece == "king") {
      opp_bishops.push(spot)
    } else if (prev_positions[spot].piece == "bishop") {
      opp_bishops.push(spot)
    } else if (prev_positions[spot].piece == "bishop") {
      opp_bishops.push(spot)
    }
  }
  prev_opp_pieces_spots := { opp_knights : opp_knights, opp_bishops : opp_bishops, opp_rooks : opp_rooks, opp_queens : opp_queens, opp_kings : opp_kings }
  return prev_opp_pieces_spots ; {"opp_kinghts: ["c6", "e6"], "opp_bishops: ["",""], ... }
}

CheckOppPiecesPositions() {
  pawn_checks := CheckPawnPositions("a7")
  knight_checks := CheckKnightPositions("a7")
  bishop_checks := CheckBishopPositions("a7")
  rook_checks := CheckRookPositions("a7")
  queen_checks := CheckQueenPositions("a7")
  king_checks := CheckKingPositions("a7")
  all_opp_checks := [pawn_checks,knight_checks,bishop_checks,rook_checks,queen_checks,king_checks]
}

CheckKnightPositions(spot) {
  jump_1 := [ 1, 2 ]
  jump_2 := [ 2, 1 ]
  jump_3 := [ 2, -1 ]
  jump_4 := [ 1, -2 ]
  jump_5 := [ 1, -2 ]
  jump_6 := [ -1, -2 ]
  jump_7 := [ -2, -1 ]
  jump_8 := [ -2, 1 ]

  sources := [ jump_1, jump_2, jump_3, jump_4, jump_5, jump_6, jump_7, jump_8 ]
  position := CheckSpot(spot)
  col := position.col
  rank := position.rank
  n := 1
}
CheckBishopPositions(spot){
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag2 := [ -1, 1 ]


  sources := [ back_one, back_two, back_diag_1, back_diag2 ]
  position := CheckSpot(spot)
  col := position.col
  rank := position.rank
  n := 1
}
CheckRookPositions(spot){
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag2 := [ -1, 1 ]
  sources := [ back_one, back_two, back_diag_1, back_diag2 ]
  position := CheckSpot(spot)
  col := position.col
  rank := position.rank
  n := 1
}
CheckQueenPositions(spot){
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag2 := [ -1, 1 ]
  sources := [ back_one, back_two, back_diag_1, back_diag2 ]
  position := CheckSpot(spot)
  col := position.col
  rank := position.rank
  n := 1
}
CheckKingPositions(spot){
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag2 := [ -1, 1 ]
  sources := [ back_one, back_two, back_diag_1, back_diag2 ]
  position := CheckSpot(spot)
  col := position.col
  rank := position.rank
  n := 1
}






; GetBothSpots() {
;   my_spots := []    ; my_spots is global array ["a3","d5","e1",...]
;   opp_spots := []
;   loop, 64 {
;     n := A_Index
;     spot := all_spots[n]   ; all_spots is global array
;     if (positions[spot].color = my_color) {
;       my_spots.push(spot)
;     } else if (positions[spot].color = opp_color) {
;       opp_spots.push(spot)
;     }
;   }
;   both_spots := [my_spots, opp_spots]
;   return both_spots
; }


; WhereIsMyKing() {
;   my_spots := GetMySpots()
;   n := 1
;   loop, 16 {
;     n := A_Index
;     spot := my_spots[n]
;     spot_piece := positions[spot].piece
;     if (spot_piece = "king") {
; ;      MsgBox, % "king found" . spot
;       return spot
;     }
;   }
; }