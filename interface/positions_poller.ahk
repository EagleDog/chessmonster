;positions_poller.ahk
; PollOpp()
; PollOppSide()
; PollOpponent()
; GetMySpots()
; GetBothSpots()
; HowManyPieces()
; WhereIsMyKing()

; global all_spots := [] pre-exists from board_map
global opp_spots := [] ;"d4","e5","b3",...
global my_spots := []  ; active spots
global both_spots := [] ; all active spots both colors


PollOppSide() {
  LogMain("poll opp territory")
  random rand_opp_spot, 33, 64
  spot := all_spots[rand_opp_spot]
  piece_color := UpdatePosition(spot)
;  if ( piece_color == opp_color ) {
;    piece := positions[spot].piece
;    LogMain("check antecedents")
;    CheckAntecedents(spot, piece)
;  }
}
PollOpponent() {
  loop 3 {
    PollOppSide()
  }
  LogMain("PollZone( zone_1 )")
  PollZone(zones["zone_1"])
  LogMain("PollZone( zone_235 )")
  PollZone(zones["zone_235"])
  LogMain("PollZone( zone_6 )")
  PollZone(zones["zone_6"])
  LogMain("PollZone( zone_4 )")
  PollZone(zones["zone_4"])
}
PollOppTerritory() {
  loop 3 {
    PollOpponent()
  }
}

GetPosition(spot) {
  position := positions[spot]
  return position
}

GetMySpots() {
  GetBothSpots()
  return my_spots
}

GetBothSpots() {
  opp_spots := []
  my_spots := []    ; my_spots is global array ["a3","d5","e1",...]
  loop, 64 {
    n := A_Index
    spot := all_spots[n]   ; all_spots is global array
    if (positions[spot].color = opp_color) {
      opp_spots.push(spot)
    } else if (positions[spot].color = my_color) {
      my_spots.push(spot)
    }
  }
  both_spots := [opp_spots, my_spots]
  return both_spots
}

HowManyPieces() {
  both_spots := GetBothSpots()
  num_pieces_opp := both_spots[1].length()
  num_pieces_mine := both_spots[2].length()
  num_pieces_both := [num_pieces_opp, num_pieces_mine]
  return num_pieces_both
}

WhereIsMyKing() {
  my_spots := GetMySpots()
  n := 1
  loop, 16 {
    n := A_Index
    spot := my_spots[n]
    spot_piece := positions[spot].piece
    if (spot_piece = "king") {
      return spot
    }
  }
}

