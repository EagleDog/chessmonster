;board_map.ahk

global board := {}
global b := board

global x_start := 194
global y_start := 875
global sq_width := 87
global sq_height := -88

; global x_start := 195
; global y_start := 880
; global sq_width := 87
; global sq_height := -88

global all_spots := []

CreateBoard() {             ; populate with x y coords 64 squares
  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank

      x := (col - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      
      board[spot] := { x: x, y: y, col: col, row: row, file: file, rank: rank, spot: spot }
      all_spots.push(spot)
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




