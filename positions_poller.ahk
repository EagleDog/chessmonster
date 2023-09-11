;positions_poller.ahk
; HowManyPieces()
; GetMySpots()
; GetBothSpots()
; PollPosition(spot)
; PostPosition(spot, piece, color, p_abbr)

; OutputPositions()
; GetAbbr(piece)

; global all_spots := [] pre-exists from board_map
global opp_spots := [] ;"d4","e5","b3",...
global my_spots := []  ; active spots
global both_spots := []
; global num_pieces_opp := 16
; global num_pieces_mine := 16

; global opp_side_squares := []

; CreateOppSideSquares()

; CreateOppSideSquares() {
;   opp_side_sq_num := 33
;   loop 32 {
;     opp_side_squares.push(opp_side_sq_num)
;     opp_side_sq_num += 1
;   }
; }

FindMyGuys(spot, spot_color) {
  while (spot_color != my_color) {   ; find my guys
    spot := ChooseSquare()
    spot_color := UpdatePosition(spot)
    MoveMouse(board[spot].x, board[spot].y)
;    MouseMove, board[spot].x, board[spot].y
  }
  return spot
}

PollOppSide() {
  LogMain("poll opp territory")
  random rand_opp_spot, 33, 64
  spot := all_spots[rand_opp_spot]
  position := PollPosition(spot)
  return position
}
PollOpponent() {
  loop 9 {
    position := PollOppSide()
    last_spot := position.spot  ;"e5"
    last_piece := position.piece ;"pawn"
;    msgbox % last_piece
    WhichPoll(last_spot)
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
  p_abbr := GetAbbr(piece, color)
  row := board[spot].row , rank := board[spot].rank
  col := board[spot].col , file := board[spot].file
  positions[spot] := { piece: piece, color: color, p_abbr: p_abbr, row: row, rank: rank, col: col, file: file }
  position := positions[spot] 
  OutputPositions()
  LogMain0("                  " . spot . "  " . p_abbr . "")
  last_spot := spot
  last_piece := piece
  return position
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

HowManyPieces() {
  both_spots := GetBothSpots()
  num_pieces_mine := both_spots[1].length()
  num_pieces_opp := both_spots[2].length()
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
