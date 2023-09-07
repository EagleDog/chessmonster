;positions_poller.ahk
; HowManyPieces()
; GetMySpots()
; GetBothSpots()
; PollPosition(spot)
; PostPosition(spot, piece, color, p_abbr)

; OutputPositions()
; GetAbbr(piece)

global my_spots := []
global opp_spots := []

global opp_side_squares := []
CreateOppSideSquares()


CreateOppSideSquares() {
  opp_side_squares := []
  opp_side_sq_num := 33
  loop 32 {
    opp_side_squares.push(opp_side_sq_num)
    opp_side_sq_num += 1
  }
}

PollOppSide() {
  LogMain("poll opp territory")
  random rand_opp_spot, 33, 64
  spot := all_spots[rand_opp_spot]
  PollPosition(spot)
}


HowManyPieces() {
  both_spots := GetBothSpots()
  num_pieces_mine := both_spots[1].length()
  num_pieces_opp := both_spots[2].length()
  num_pieces_both := my_color . " " . num_pieces_mine . "  " . opp_color . " " . num_pieces_opp
  return num_pieces_both
}

PollPosition(spot) {
  color := SquareStatus(spot)
  piece := IDPiece(spot, color)
  p_abbr := GetAbbr(piece, color)
  positions[spot] := { piece: piece, color: color, p_abbr: p_abbr }
  OutputPositions()
  LogMain0(" " . p_abbr . "     " . spot . "     " . spot . "     " . p_abbr . "")
}

PostPosition(spot, piece, color, p_abbr) {
  OutputPositions()
}

GetMySpots() {
  GetBothSpots()
  return my_spots
}

GetBothSpots() {
  my_spots := []    ; my_spots is global array ["a3","d5","e1",...]
  opp_spots := []
  loop, 64 {
    n := A_Index
    spot := all_spots[n]   ; all_spots is global array
    if (positions[spot].color = my_color) {
      my_spots.push(spot)
    } else if (positions[spot].color = opp_color) {
      opp_spots.push(spot)
    }
  }
  both_spots := [my_spots, opp_spots]
  return both_spots
}

WhereIsMyKing() {
  my_spots := GetMySpots()
  n := 1
  loop, 16 {
    n := A_Index
    spot := my_spots[n]
    spot_piece := positions[spot].piece
    if (spot_piece = "king") {
;      MsgBox, % "king found" . spot
      return spot
    }
  }
}
