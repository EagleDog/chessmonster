;board_map.ahk

global board := {}
global b := board

global x_start := 195
global y_start := 880
global sq_width := 87
global sq_height := -88

GetMyColor() {
  if SquareStatus("a1") = "white" {
    my_color := "white"
    opp_color := "black"
  } else {
    my_color := "black"
    opp_color := "white"
  }
}

CreateBoard() {             ; populate with x y coords 64 squares
  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      column := A_Index
      file := Chr(96 + column)     ; a_index > a-h
      spot := file . rank

      x := (column - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      
      board[spot] := { x: x, y: y, rank: rank, file: file, column: column, spot: spot }
    }
  }
  b := board
}

FlipBoard() {
  b := board
  if (my_color = "black") {
    my_color := "black"
  }
  b := board
}



