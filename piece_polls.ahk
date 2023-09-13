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
;  last_spot := last_spot ;"e5" ;last_spot  ; global var e.g. "a6"
;  last_piece := last_piece  ; global var e.g. "empty"

;  tooltip % last_spot . " last_spot"
 
  ; tooltip % last_piece . " last_piece"


  switch last_piece {
    case "empty":
      DoNothing()
      return "empty"
    case "pawn":
      CheckPawnMoves(last_spot) ,  return "pawn"
    case "knight":
      CheckKnightMoves(last_spot) ,  return "knight"
    case "bishop":
      CheckBishopMoves(last_spot) ,  return "bishop"
    case "rook":
      CheckRookMoves(last_spot) ,  return "rook"
    case "queen":
      CheckQueenMoves(last_spot) ,  return "queen"
    case "king":
      CheckKingMoves(last_spot) ,  return "king"
  }
}

CheckPawnMoves(spot) {
;  msgbox % spot . " " . last_spot . last_piece . " :  last spot "
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
;    msgbox % col
    rank += sources[n][2]
    file := FindFile(col)
    spot := file . rank
;    msgbox % spot . "     "
  }
}

CheckSpot(spot) {
  position := PollPosition(spot)
;  GoSpot(spot)
  return position
}

PrevOppPiecesSpots() {
  opp_pawns := []
  opp_knights := []  ; ["b8", "g8"]
  opp_bishops := []  ; ["c8", "f8"]
  opp_rooks := []
  opp_queens := []
  opp_kings := []
  prev_opp_pieces_spots := {}
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

CheckOppPiecesMoves() {
  pawn_checks := CheckPawnMoves("a7")
  knight_checks := CheckKnightMoves("a7")
  bishop_checks := CheckBishopMoves("a7")
  rook_checks := CheckRookMoves("a7")
  queen_checks := CheckQueenMoves("a7")
  king_checks := CheckKingMoves("a7")
  all_opp_checks := [pawn_checks,knight_checks,bishop_checks,rook_checks,queen_checks,king_checks]
}

CheckKnightMoves(spot) {
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
CheckBishopMoves(spot){
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
CheckRookMoves(spot){
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
CheckQueenMoves(spot){
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
CheckKingMoves(spot){
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