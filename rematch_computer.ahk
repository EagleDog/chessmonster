;
;     rematch_computer.ahk
;
;  calls MovePiece(spot, target)
;
;


plus_sign_button_spot := [980, 860]
plus_sign_button_color := 0x454441




big_green_button_spot := [380, 410]
big_green_button_color := 0xa3d160

Aaaaa() {
  MovePiece("a2", "a3")
}



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
  sleep 100
  sleep 50

  mousemove rematch_button_spot_a[1], rematch_button_spot_a[2]
  click rematch_button_spot_a[1], rematch_button_spot_a[2]
  sleep 600

  mousemove yes_button_spot[1], yes_button_spot[2]
  click yes_button_spot[1], yes_button_spot[2]
  sleep 800

  mousemove rematch_button_spot_a[1], rematch_button_spot_a[2]
  click rematch_button_spot_a[1], rematch_button_spot_a[2]
  sleep 600

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
