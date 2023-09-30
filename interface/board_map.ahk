;board_map.ahk

global board := {}
global b := board

global x_start := 194
global y_start := 875
global sq_width := 87
global sq_height := -88
global scale := 1

global all_spots := []

global display_size := "HP" ; default is "HP"
                            ; "laptop" is 1920 x 1080 ("recommended")
;AdjustDisplaySize()


CreateBoard() {             ; populate with x y coords 64 squares
LogMain("CreateBoard()")
sleep 200
  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      col := A_Index
      file := ColToFile(col)     ; a_index > a-h
      spot := file . rank

      x := (col - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      
      board[spot] := { spot: spot, x: x, y: y, col: col, file: file, row: row, rank: rank }
      all_spots.push(spot)
    }
  }

  b := board
}

AdjustDisplaySize() {
  if ( display_size == "laptop" ) { ; laptop 1920 x 1080
    assets_path := assets_path . "\assets2\"
    x_start := 146 + 46
    y_start := 938 - 46
    sq_width := 92
    sq_height := -92

    scale := 1.15
    new_width := 41

  }
}

