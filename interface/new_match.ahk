;new_match.ahk
;
;

TimeoutRandomized() {
  if RandomChoice(4) {
    timeout := 2000
  } else {
    random timeout, 3000, 8000
  }
  return timeout
}

RematchSequence(timeout=10000) {
  refreshed := false
  sleep 1000
  gui hide
  ClickEmpty()
  sleep 100
  if ( timeout == 10000) {
    timeout := TimeoutRandomized()
  }
  if CheckRefresh() {
    send {f5}
    refreshed := true
    sleep 1000
  }  
  if FindPlayers() {
    gui show
    RematchLive(timeout, refreshed)
  } else {
    gui show
    RematchComputer(timeout)
  }
}

RematchLive(timeout=10000, refreshed=false) {
  ClearLogFields()
  LogField2("rematch live")
  MoveGui2()
  ClickEmpty()
  ShowTimeoutTimer(timeout)
  ; Beep()
  ; sleep 100
  ; gui hide
  ; sleep 50
  ; gui show
  ; sleep 100
  if refreshed {
    ButtonA()
  } else {
    ButtonB()
    sleep 100
    ButtonB()
  }
  sleep 500
  MoveGui1()
  NewGame()
}

; NewMatchFailSafe() {
;   sleep 500
;     MovePiece("e2", "e4")
;     MovePiece("d7", "d6")
;   ; if ( my_color == "white") {
;   ;   MovePiece("e2", "e4")
;   ; }
;   GetMyColor()
; }

RematchComputer(timeout=10000) {
  ClearLogFields()
  LogField2("rematch cpu")
  MoveGui2()
  ClickEmpty()
  ShowTimeoutTimer(timeout)
  ; sleep % timeout
  ButtonA()     ; move click A
  sleep 800
  EscKey()      ; press Esc
  sleep 400
  ButtonA()
  sleep 400
  YesButton()   ; move click Yes
  sleep 800
  ; Beep()
  ; sleep 100
  ; gui hide
  ; sleep 50
  ; gui show
  ; sleep 100
  ButtonA()     ; move click A
  sleep 50
  ClickEmpty()  ; click empty space (hide remaining browser dialogs)
  sleep 50
  MoveGui1()
  NewGame()
}

ShowTimeoutTimer(timeout) {
  while ( timeout > 0 ) {
    LogField3("intermission ")
    LogField4(Floor(timeout/1000))
    sleep, 1000
    timeout := timeout - 1000
  }
}

DidGameEnd() {
  if CheckBackfield() {
  ; if FindVS() {
    RematchSequence()
  }
}

CheckBackfield() {
  backfield_color := 0x212426
  ; back_fieldcolor := 0x262421
  ; back_fieldcolor := 0x3C3A38
;  x1:= 320, y1 := 285, x2 := 323, y2 := 288
  x1:= 325, y1 := 820, x2 := 328, y2 := 823
  ; x1:= 330, y1 := 460, x2 := 333, y2 := 463
  matches := CheckColorCoords(x1, y1, x2, y2, backfield_color)
;  PixelSearch, found_x, found_y, x1, y1, x2, y2, backfield_color, 30, Fast
  ; if found_x {
  ;   return true
  ; }
  return matches
}

FindVS() {
  vs_path := assets_path "vs.png"
  x1 := 480, y1 := 240
  x2 := 520, y2 := 410
  if ImageMatches(x1, y1, x2, y2, vs_path) {
    return true
  }
}

FindPlayers() {
  players_path := assets_path "players.png"
  x1 := 1265, y1 := 175
  x2 := 1365, y2 := 220
  if ImageMatches(x1, y1, x2, y2, players_path) {
    return true
  }
}

CheckRefresh() {
  x1 := 1265, y1 := 175
  x2 := x1 + 6, y2 := y1 + 6
  refresh_blue := 0xD18C00
  ; refresh_blue := 0x008CD1
  matches := CheckColorCoords(x1, y1, x2, y2, refresh_blue)
  return matches
}


EscKey() {
  send {esc}
}

ButtonA() {
  button_a_x := 940, button_a_y := 860
  MoveClick(button_a_x, button_a_y)
}

ButtonB() {
  button_b_x := 950, button_b_y := 680
  MoveClick(button_b_x, button_b_y)
}

YesButton() {
  yes_x := 1020, yes_y := 770
  MoveClick(yes_x, yes_y)
}


ClickEmpty() {
  x := 880, y := 700
  MoveClick(x, y)
}


;
;
;
;
;
;
;
;
;
;  old stuff below
;
;

New3Min() {
  new_3_spot_a := [965, 875]
  new_3_spot_b := [965, 675]
  new_3_spot_center := [470, 550]
  new_3_spot_center_color := 0x494745

  MoveGui2()
  sleep 100
  MoveClick(new_3_spot_center[1], new_3_spot_center[2])
  ; MoveClick(new_3_spot_b[1], new_3_spot_b[2])
  ; MoveClick(new_3_spot_a[1], new_3_spot_a[2])
  sleep 200
  MoveGui1()
}

plus_sign_button_spot := [980, 860]
plus_sign_button_color := 0x454441

big_green_button_spot := [380, 410]
big_green_button_color := 0xa3d160

; RematchComputer() {
;   MoveGui2()

;   rematch_button_spot_a := [940,860]
;   rematch_button_color_a := 0x90be59
;   rematch_button_spot_b := [950,860]
;   rematch_button_color_b := 0x94c25a

;   yes_button_spot :=  [1040, 790]
;   yes_button_spot :=  [1020, 770]
;   yes_button_spot_color := 0x98c65b

;   sleep 50

;   mousemove rematch_button_spot_a[1], rematch_button_spot_a[2]
;   click rematch_button_spot_a[1], rematch_button_spot_a[2]
;   sleep 400

;   mousemove yes_button_spot[1], yes_button_spot[2]
;   click yes_button_spot[1], yes_button_spot[2]
;   sleep 800

;   mousemove rematch_button_spot_a[1], rematch_button_spot_a[2]
;   click rematch_button_spot_a[1], rematch_button_spot_a[2]
;   sleep 50

;   MoveGui1()
;   NewGame()
; }

CheckForGameEnd(old) {
;  three_spot := [400, 475]
  three_spot := [400, 555]
  three_image := "three.png"
  img_path := assets_path . three_image
  x := three_spot[1]
  y := three_spot[2]
  x1 := x - 25
  y1 := y - 25
  x2 := x + 25
  y2 := y + 25
;  MsgBox, % img_path
  if ImageMatches(x1, y1, x2, y2, img_path) {
    MoveMouse(x, y)
    Click, x, y
    Sleep, 1000
    NewGame()
  } else {
    MoveMouse(x, y)
  }
}

;
; __mouse_mover__  for testing
;
; GoClick(spot) {
;   MouseMove, board[spot].x, board[spot].y
;   Click
; }
;
; MovePiece(spot, target) {
;   ClickDrag(spot, target)
;   UpdatePosition(spot)
;   UpdatePosition(target)
;   move_num += 1
;   LogMoves("Move # " . move_num)
; }
;
; ClickDrag(spot, target) {  ; L-Left b-board 2-Speed 0-100
;   MouseClickDrag, L, b[spot].x, b[spot].y, b[target].x, b[target].y, 2
; }
;
;
