;board_map.ahk

global board := {}
global b := board

global x_start := 195
global y_start := 880
global sq_width := 87
global sq_height := -88

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
      
      board[spot] := {  x: x, y: y, rank: rank, file: file, column: column }
    }
  }
  b := board
  return
}



FlipBoard() {
  if (my_color = "white") {
    my_color := "white"
  } else {
    my_color := "black"
    b := board
  }
}



