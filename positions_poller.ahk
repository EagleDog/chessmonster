;positions_poller.ahk
; PollOppSide()
; PollOpponent()
; LastPiece(spot)
; GetMySpots()
; GetBothSpots()
; PollPosition(spot)
; PostPosition(spot, piece, color, abbr)
; HowManyPieces()
; WhereIsMyKing()

; global all_spots := [] pre-exists from board_map
global opp_spots := [] ;"d4","e5","b3",...
global my_spots := []  ; active spots
global both_spots := [] ; all active spots both colors

DidSquareChange(spot) {
  ; was piece here previous move?
  ; ... but ... what if it got missed?...
  if ( move_num == 1 ) {
    return
  }
  position := positions[spot]
  snapshot := snapshots[move_num - 1]
  snapspot := snapshot[spot]
  piece := position.piece
  color := position.color
  abbr := position.abbr
;  snapshot := snapshots[move_num]
  prev_piece := snapshot[spot].piece
  prev_color := snapshot[spot].color
  prev_abbr := snapshot[spot].abbr
  if ( ( prev_piece == piece ) and ( prev_color == color ) ) {
    return false
  } else {
    GoSpot(spot)
;    msgbox % "prev: "prev_color . prev_piece . " curr: " . color . piece
    snapshot[spot] := {piece: piece, color: color, abbr: abbr}
    return true
  }
}

PollOppSide() {
  LogMain("poll opp territory")
  random rand_opp_spot, 33, 64
  spot := all_spots[rand_opp_spot]
  piece_color := UpdatePosition(spot)
  if ( piece_color == opp_color ) {
    piece := positions[spot].piece
;    LogMain("check antecedents")
;    CheckAntecedents(spot, piece)
  }
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

LastPiece(spot) {   ; unused
  last_spot := last_poll
  last_position := GetPosition(spot)
  last_piece := last_position.piece
  return last_piece
  ; position := positions[spot]
  ; msgbox % position.spot
}

GetPosition(spot) {
  position := positions[spot]
  return position
}

PollPosition(spot) {
  last_spot := spot
  color := SquareStatus(spot)
  piece := IDPiece(spot, color)
  abbr := GetAbbr(piece, color)
  row := board[spot].row , rank := board[spot].rank
  col := board[spot].col , file := board[spot].file
  positions[spot] := { piece: piece, color: color, abbr: abbr, row: row, rank: rank, col: col, file: file }
  position := positions[spot] 
;  OutputPositions()
  LogMain0("                  " . spot . "  " . abbr . "")
;  last_spot := spot
;  last_piece := piece
;  return position
}

PostPosition(spot, piece, color, abbr) {
  OutputPositions()
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
  ; num_pieces_both := my_color . " " . num_pieces_mine . "  " . opp_color . " " . num_pieces_opp
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
