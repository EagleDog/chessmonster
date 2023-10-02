;positions_poller.ahk
; PollOpp()
; PollOppSide()
; PollOpponent()
; GetMySpots()
; GetBothSpots()
; HowManyPieces()
; WhereIsMyKing()

; global all_spots := [] pre-exists from board_map
global black_spots := [] ;"d4","e5","b3",...
global white_spots := []  ; active spots
global both_spots := [] ; all active spots both colors


PollOppSide() {
  LogField4("poll opp territory")
  random rand_opp_spot, 33, 64
  spot := all_spots[rand_opp_spot]
  piece_color := UpdatePosition(spot)
;  if ( piece_color == opp_color ) {
;    piece := positions[spot].piece
;    LogField1("check antecedents")
;    CheckAntecedents(spot, piece)
;  }
}
PollOpponent() {
  loop 3 {
    PollOppSide()
  }
  LogField1("PollZone( zone_1 )")
  PollZone(zones["zone_1"])
  LogField1("PollZone( zone_235 )")
  PollZone(zones["zone_235"])
  LogField1("PollZone( zone_6 )")
  PollZone(zones["zone_6"])
  LogField1("PollZone( zone_4 )")
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
  if ( my_color == "black" ) {
    return black_spots
  } else {
    return white_spots
  }
}

GetBothSpots() {
  black_spots := []
  white_spots := []    ; white_spots is global array ["a3","d5","e1",...]
  loop, 64 {
    n := A_Index
    spot := all_spots[n]   ; all_spots is global array ["a1","a2","a3",...]
    if (positions[spot].color = "black") {
      black_spots.push(spot)
    } else if (positions[spot].color = "white") {
      white_spots.push(spot)
    }
  }
  both_spots := [black_spots, white_spots]
  return both_spots
}

HowManyPieces() {
  both_spots := GetBothSpots()
  num_pieces_black := both_spots[1].length()
  num_pieces_white := both_spots[2].length()
  num_pieces_both := [num_pieces_black, num_pieces_white]
  ; num_pieces_both := [num_pieces_opp, num_pieces_mine]
  ; if ( my_color == "white" ) {
  ;   num_pieces_both := [num_pieces_opp, num_pieces_mine]
  ; } else {
  ;   num_pieces_both := [num_pieces_mine, num_pieces_opp]
  ; }
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

