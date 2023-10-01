
global opening_moves_white := []
global opening_moves_black := []
global opening_moves := []

move1_wh := ["e2", "e4"] ; e pawn
move2_wh := ["g1", "f3"] ; g Nnight
move3_wh := ["f1", "c4"] ; f Bishop (light)
move4_wh := ["d2", "d3"] ; d pawn
move5_wh := ["b1", "c3"] ; b Nnight
move6_wh := ["c1", "e3"] ; c Bishop (dark)
move7_wh := ["e1", "h1"] ; O-O
move8_wh := ["d1", "e2"] ; d Queen
move9_wh := ["a2", "a3"] ; a pawn
move10_wh := ["h2", "h3"] ; f bishop (light)

move1_bl := ["f2", "f3"] ; f pawn
move2_bl := ["e2", "e4"] ; e pawn
move3_bl := ["g1", "f3"] ; g Nnight
move4_bl := ["f1", "d4"] ; f Bishop (light)
move5_bl := ["d2", "d3"] ; d pawn
move6_bl := ["b1", "c3"] ; b Nnight
move7_bl := ["c1", "e3"] ; c Bishop (dark)
move8_bl := ["d1", "a1"] ; O-O
move9_bl := ["e1", "d2"] ; e Queen
move10_bl := ["h2", "h3"] ; h pawn
move11_bl := ["a2", "a3"] ; a pawn

opening_moves_white := [move1_wh, move2_wh, move3_wh, move4_wh, move5_wh, move6_wh, move7_wh, move8_wh, move9_wh, move10_wh]
opening_moves_black := [move1_bl, move2_bl, move3_bl, move4_bl, move5_bl, move6_bl, move7_bl, move8_bl, move9_bl, move10_bl]
opening_moves := opening_moves_white

MakeOpeningMove() {
  MovePiece(opening_moves[move_num].1, moves[move_num].2)
}
MakeMove() {
  if (move_num <= 10) {
    MakeOpeningMove()
  } else {
    DoNothing()
  }
}

TryMove(spot, piece_type) {
  LogField1("try move" . piece_type . " " . spot)
  return spot
}
