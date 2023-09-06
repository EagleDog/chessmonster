;
;     rematch_computer.ahk
;
;  calls MovePiece(spot, target)
;
;



plus_sign_button_spot := [980, 860]

yes_button_spot :=  [1040, 790]








Aaaaa() {
  MovePiece("a2", "a3")
}


RematchLoop() {
  sleep 50
  





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
