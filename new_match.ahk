;
;     new_match.ahk
;
;  calls MovePiece(spot, target)
;
;
; RematchComputer()
; New3Min()
;
;
;

plus_sign_button_spot := [980, 860]
plus_sign_button_color := 0x454441




big_green_button_spot := [380, 410]
big_green_button_color := 0xa3d160


RematchComputer() {
  MoveGui2()

  rematch_button_spot_a := [940,860]
  rematch_button_color_a := 0x90be59
  rematch_button_spot_b := [950,860]
  rematch_button_color_b := 0x94c25a

  yes_button_spot :=  [1040, 790]
  yes_button_spot :=  [1020, 770]
  yes_button_spot_color := 0x98c65b

  sleep 100

  mousemove rematch_button_spot_a[1], rematch_button_spot_a[2]
  click rematch_button_spot_a[1], rematch_button_spot_a[2]
  sleep 700

  mousemove yes_button_spot[1], yes_button_spot[2]
  click yes_button_spot[1], yes_button_spot[2]
  sleep 900

  mousemove rematch_button_spot_a[1], rematch_button_spot_a[2]
  click rematch_button_spot_a[1], rematch_button_spot_a[2]
  sleep 600

  MoveGui1()
  NewGame()
  ; GetStartingPositions()
}

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


;
; __mouse_mover__
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
