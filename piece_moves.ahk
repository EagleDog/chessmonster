;piece_moves.ahk


MovePawn1(spot) {
  diags := FindDiags(spot)
  diag_1 := diags[1] ;spot
  diag_2 := diags[2] ;spot
  diag_1_status := SquareStatus(diag_1)
  diag_2_status := SquareStatus(diag_2)
  if (SquareStatus(diag_1) = "enemy_color") {
    target := diag_1
  } else if (SquareStatus(diag_1) = "enemy_color") {
    target := diag_2
  } else
  return "no diags"
}

MovePawn2() {

  return
}

MovePawn3() {

  return
}


FindDiags(spot) {
  rank := board[spot].rank
  col := board[spot].column

  diag_1_rank := rank + 1
  diag_1_col := col - 1
  diag_1_file := Chr(96 + diag_1_col)
  diag_1_spot := "" . diag_1_file . diag_1_rank . ""

  diag_2_rank := rank + 1
  diag_2_col := col + 1
  diag_2_file := Chr(96 + diag_2_col)
  diag_2_spot := "" . diag_2_file . diag_2_rank . ""

  MsgBox, % "diag_1: " . diag_1_spot . "diag_2: " . diag_2_spot . ""

  return [diag_1_spot, diag_2_spot]
}

