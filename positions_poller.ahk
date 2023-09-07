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
  num_pieces_white := both_spots[1].length()
  num_pieces_black := both_spots[2].length()
  num_pieces_both := " W  " . num_pieces_white . "     B  " . num_pieces_black
  return num_pieces_both
}

PollPosition(spot) {
  color := SquareStatus(spot)
  piece := IDPiece(spot, color)
  p_abbr := GetAbbr(piece, color)
  positions[spot] := { piece: piece, color: color, p_abbr: p_abbr }
}

PostPosition(spot, piece, color, p_abbr) {
  OutputPositions()
}

GetMySpots() {
  GetBothSpots()
  return my_spots
}

GetBothSpots() {
  my_spots := []
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

