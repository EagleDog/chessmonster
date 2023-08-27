;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87

; global x_begin := 191
; global y_begin := 861
; global x_incr := 87
; global y_incr := -95
; global a1 := [191, 861]
; global b1 := [0, 0]
; global x_pos := 0
; global y_pos := 0
; global black := 0x565352
; global board_gr := 0x779954
; global board_wh := 0xEDEDCC


#Include VA.ahk

; Exit
; Pause On

global board := {}

global x_start := 195
global y_start := 880
global sq_width := 87
global sq_height := -88


global black := 0x525356
global white := 0xF8F8F8
global board_gr := 0x549977
global board_wh := 0xCCEDE9

move1 := ["e2", "e4"] ; e pawn
move2 := ["g1", "f3"] ; g Nnight
move3 := ["f1", "c4"] ; f Bishop (light)
move4 := ["d2", "d3"] ; d pawn
move5 := ["b1", "c3"] ; b Nnight
move6 := ["c1", "e3"] ; c Bishop (dark)
move7 := ["e1", "h1"] ; O-O
move8 := ["d1", "d2"] ; d Queen
move9 := ["a2", "a3"] ; a pawn
move10 := ["c4", "b3"] ; f bishop (light)


global moves := [move1, move2, move3, move4, move5, move6, move7, move8, move9, move10]
global next_move := 1

global my_color := "white"

; MAIN LOOP =====================      MAIN LOOP      MAIN LOOP

;make_new_position()
CreateBoard()
GetMyColor()
;Output()


;      END MAIN LOOP ============   END MAIN LOOP END     END MAIN LOOP END

Listen() {
;  msgbox, Listening...
  triggerVol := 0.0001
  audioMeter := VA_GetAudioMeter()
  VA_IAudioMeterInformation_GetMeteringChannelCount(audioMeter, channelCount)
  VA_GetDevicePeriod("capture", devicePeriod)
;  Return
  VA_IAudioMeterInformation_GetPeakValue(audioMeter, peakValue)
  ;msgbox, %peakValue% 
  loop{
    while (peakValue > triggerVol)
    {
;      click
;      SoundBeep
      msgbox, I heard that
      sleep, 20
      VA_IAudioMeterInformation_GetPeakValue(audioMeter, peakValue) 
    }
    sleep, 10
  }
}




NewGame() {
  next_move := 1
  GetMyColor()
  FlipBoard()
}

GetMyColor() {
  if SquareID("a1") = "white" {
    my_color := "white"
  } else {
    my_color := "black"
  }
}

FlipBoard() {
  if (my_color = "white") {
    my_color := "white"
  } else {
    my_color := "black"
  }
}

DriftMouse() {
  Random, x, 0, 80
  Random, y, 0, 80  
  Random, speed, 1, 7 
  MouseMove, x - 40, y - 40, speed, Relative
}

MovePiece(source, target) {
  MouseMove, board[source].x, board[source].y
  Click, Down
  MouseMove, board[target].x, board[target].y
  Click, Up
}

MakeMove() {
  if (next_move >= 11) {
    TryMove()
    ; MsgBox, No more moves.
    ; next_move := 1
  } else {
    MovePiece(moves[next_move].1, moves[next_move].2)
    ; MsgBox, % " the_move: " . moves[next_move].1 . "  " . moves[next_move].2 . ""
    next_move += 1
  }
}

TryMove() {
  Sleep, 10
  source := RandomSquare()
  while (SquareID(source) != my_color) {
    sleep, 10
    ; MsgBox, % "Source: " . source . " SquareID source:  " . SquareID(source) . "   my_color:  " . my_color . ""
    MouseMove, board[source].x, board[source].y
    sleep, 10
    source := RandomSquare()
  }
  target := RandomSquare()
  ; while (SquareID(target) = my_color) {
  ;   target := RandomSquare()
  ; }
  x1 := board[source].x
  y1 := board[source].y
  x2 := board[target].x
  y2 := board[target].y
         ; Left button, x1, y1, x2, y2 [, speed 0-100, relative]
  MouseClickDrag, Left, x1, y1, x2, y2, 3
  Sleep, 10
}

ChooseMove() {
  MsgBox, % RandomSquare()
}

RandomSquare() {
  Random, rank, 1, 8
  Random, file, 1, 8
;  rank := rand_num1
  file := Chr(96 + file)   ; file > a-h
  spot := file . rank
  return spot
}



CreateBoard() {             ; populate with x y coords 64 squares

  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      column := A_Index
      file := Chr(96 + column)     ; a_index > a-h
      spot := file . rank
      
      ; Calculate x and y coordinates based on square position
      x := (column - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      
      ; Create an object for the square and store its coordinates
      board[spot] := { x: x, y: y }
;      MsgBox, % "board info: " . board["a1"].x . ""
    }
  }
  return
}











Output() {
  MsgBox, % "a1:  x: " . board["a1"].x . "  y: " . board["a1"].y . ""
  MsgBox, % "a2:  x: " . board["a2"].x . "  y: " . board["a2"].y . ""
  MsgBox, % "b1:  x: " . board["b1"].x . "  y: " . board["b1"].y . ""
  MsgBox, % "b2:  x: " . board["b2"].x . "  y: " . board["b2"].y . ""
}

FindMyGuys() {
;  source := "a1"
  source := RandomSquare()
  ; if (SquareID(source) = my_color) {
  ; } else {
    while (SquareID(source) != my_color) {
      sleep, 50
      MouseMove, board[source].x, board[source].y
      MsgBox, % "Source: " . source . "  ID: " . SquareID(source) . "   my_color: " . my_color . ""
      sleep, 50
      source := RandomSquare()
    }
    sleep, 50
    MouseMove, board[source].x, board[source].y
    MsgBox, % "Found my guy.  Source: " . source . "  ID: " . SquareID(source) . "   my_color: " . my_color . ""


;  }
}






SquareID(spot) {
  if ColorTest(spot, white) {
    sq_contains := "white"
  } else if ColorTest(spot, black) {
    sq_contains := "black"
  } else if ColorTest(spot, board_gr) {
    sq_contains := "board green"
  } else if ColorTest(spot, board_wh) {
    sq_contains := "board light"
  } else {
    sq_contains := "not sure"
  }
  return sq_contains
}

ColorTest(spot, the_color) {
  x1 := board[spot].x - 2
  y1 := board[spot].y - 2
  x2 := board[spot].x
  y2 := board[spot].y
  PixelSearch, found_x, found_y , x1, y1, x2, y2, the_color, 10, Fast
  if found_x {
    return true
  } else {
    return false
  } 
}

GetColor(spot) {
  x := board[spot].x
  y := board[spot].y
  PixelGetColor, spot_color, x, y
  MsgBox, % "spot_color is:  " . spot_color . ""
}

CheckColor(spot, the_color, color_name) {
  x1 := board[spot].x - 2
  y1 := board[spot].y - 2
  x2 := board[spot].x
  y2 := board[spot].y

  ; if color_name = "board_gr" or "board_wh"
  ;   variation = 60
  ; else
  ;   variation = 20

  PixelSearch, color_x, color_y , x1, y1, x2, y2, the_color, 10, Fast
  MouseMove, x2, y2
  If color_x {
    MsgBox, %color_name%
  } Else {
    MsgBox, Not %color_name%
  }
;  GetColor(spot)
}

;======= KEYBOARD SHORTCUTS ===================

^+z::Pause           ; ctrl + shift + z
^+x::ExitApp            ; ctrl + shift + x

; 1::GetColor("b3")
; 2::GetColor("c3")
; 3::GetColor("d1")
; 4::GetColor("a6")

; 1::MovePiece("e2", "e4")
; 2::MovePiece("d2", "d3")
; 3::MovePiece("a2", "a3")
; 4::MovePiece("g1", "f3")

; a::CheckColor("c7", black, "black")
; s::CheckColor("d7", black, "black")
; d::CheckColor("e7", black, "black")
; f::CheckColor("f3", black, "black")

; z::CheckColor("b3", white, "white")
; x::CheckColor("c3", white, "white")
; c::CheckColor("d3", white, "white")
; v::CheckColor("d4", board_gr, "board_gr")
; b::CheckColor("d5", board_wh, "board_wh")
; n::CheckColor("f3", board_wh, "board_wh")
; m::CheckColor("g3", board_wh, "board_wh")



1::NewGame()
2::TryMove()
3::DriftMouse()
4::FindMyGuys()

0::Listen()