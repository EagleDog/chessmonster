;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87

#Include chess_gui.ahk
#Include VA.ahk
#Include listener.ahk
#Include board_map.ahk
#Include board_watcher.ahk
#Include positions_watcher.ahk
#Include positions_poller.ahk
#Include rematch_computer.ahk
#Include mouse_mover.ahk

#Include pawn_mover.ahk
#Include knight_mover.ahk
#Include bishop_mover.ahk
#Include rook_mover.ahk
#Include queen_mover.ahk
#Include king_mover.ahk

global rel_path := "" . A_ScriptDir . "\assets\"
;global img_path := %rel_path%p_wh_wh.png
;global img_path := "" . rel_path . "p_wh_wh.png"

; Exit
; Pause On

global my_color := "white"
global opp_color := "black"
;global target_status := "empty"

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
global move_num := 0

;
;
;
;
;  =====================================================================
;    === BEGIN MAIN SEQUENCE ===================      MAIN LOOP      MAIN LOOP

CreateGui()
LogMain("CreateGUI()")
LogMain("ActivateChess()")
ActivateChess()
sleep, 400
LogMain("CreateBoard()")
CreateBoard()
sleep, 400
LogMain("GetMyColor()")
GetMyColor()
sleep, 400
LogMain("GetStartingPositions()")
GetStartingPositions()
sleep, 400

;CheckForGameEnd()



;   ===== END MAIN SEQUENCE ================    END MAIN LOOP
; ======================================================================
;
;
;
;

;**********************************************************************************************
;
;    BeginFunctions()     BeginFunctions()      BeginFunctions()      BeginFunctions()
;
;**********************************************************************************************
;
ActivateChess() {
  if WinExist("Play Chess") {
    WinActivate, Play Chess
  }
}
NewGame() {
  ActivateChess()
  move_num := 0
  GetMyColor()
  GetStartingPositions()
  FlipBoard()
  Sleep, 500
  MakeMove()
}

MakeMove() {
;  if (move_num >= 11) {
  if (move_num <= 1) {
    TryMove()
  } else {
    MovePiece(moves[move_num].1, moves[move_num].2)
  }
}

         ; calls ChooseSquare(), SquareStatus(spot),
TryMove() {   ;  IDPiece(spot), TryMove(), MovePiece(spot, target)
  Loop {      ;  MovePawn(spot), MoveKnight(spot), MoveBishop(spot),
    Sleep, 10   ; MoveRook(spot), MoveQueen(spot), MoveKing(spot)
    spot := ChooseSquare()
    spot_color := UpdatePosition(spot)
    ; spot_color := SquareStatus(spot)
  
    while (spot_color != my_color) {   ; find my guys
      sleep 10
      MouseMove, board[spot].x, board[spot].y
      sleep 10
      spot := ChooseSquare()
      spot_color := UpdatePosition(spot)
      sleep 10
      MouseMove, board[spot].x, board[spot].y
    }
    piece_type := IDPiece(spot, spot_color)  ;       <<============

    LogMain("try move")
   ; if ( (piece_type != "bishop") ) {
   ;   TryMove()
   ; }
    switch piece_type {
      case "pawn":
        target := MovePawn(spot)
      case "knight":
        target := MoveKnight(spot)
      case "bishop":
        target := MoveBishop(spot)
      case "rook":
        target := MoveRook(spot)
      case "queen":
        target := MoveQueen(spot)
      case "king":
        target := MoveKing(spot)
    }
    LogMain(piece_type . "    '" . spot . "'" )
    sleep 500

    if target {
      LogMain("MovePiece: " . piece_type . " '" . spot . "'" )
      MovePiece(spot, target)
      ;
      ;  current work: failed move detection
      ;                in mouse_mover.ahk
      ;
      if ( (piece_type = "pawn") AND (target contains 8) ) {
        sleep 100
        mouseclick Left    ;  Promotion  choose queen
      }
      sleep 100

      Listen()

      sleep 200
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      PollOppSide()
      sleep 50
    }
  }
}

ChooseSquare() {
  LogMain("ChooseSquare()")
  if ( failed_moves > 0 ) {   ; failed_moves from mouse_mover.ahk
    LogMain("FailedChooseSquare()")
    spot := FailedChooseSquare()
  } else if ( RandomChoice(3) ) {
    spot := ChooseMySpots()
    ; my_spots := GetMySpots()
    ; length_my_spots := my_spots.length()
    ; Random, spot_num, 1, length_my_spots
    ; spot := my_spots[spot_num]
    ; LogMain("ChooseSquare() " . spot . " my guy")
    ; sleep 200
  } else {
    spot := RandomSquare()
    LogMain("ChooseSquare() " . spot . " rand square")
    sleep 200
  }
  return spot
}

ChooseMySpots() {
    my_spots := GetMySpots()
    length_my_spots := my_spots.length()
    Random, spot_num, 1, length_my_spots
    spot := my_spots[spot_num]
    LogMain("ChooseSquare() " . spot . " my guy")
    sleep 200
    return spot
}

FailedChooseSquare() {
  LogMain("FailedChooseSquare()")
  if RandomChoice() {
    king_spot := WhereIsMyKing()
    if ( king_spot ) {
      spot := king_spot
    } else {
      spot := ChooseMySpots()
    }
  } else {
    spot := ChooseMySpots()
  }
  return spot
}

RandomSquare() {
  random, col, 1, 8
  random, rank, 1, 8
  file := Chr(96 + col)   ; file > a-h
  spot := file . rank
  return spot
}

RandomChoice(max=1) {
  random, choice, 0, max
  if (choice = 1) {
    return true
  } else {
    return false
  }
}


Output() {
  MsgBox, % "a1:  x: " . board["a1"].x . "  y: " . board["a1"].y . ""
  MsgBox, % "a2:  x: " . board["a2"].x . "  y: " . board["a2"].y . ""
  MsgBox, % "b1:  x: " . board["b1"].x . "  y: " . board["b1"].y . ""
  MsgBox, % "b2:  x: " . board["b2"].x . "  y: " . board["b2"].y . ""
}

MyColorWhite() {
  my_color := "white"
  opp_color := "black"
}

MyColorBlack() {
  my_color := "black"
  opp_color := "white"
}

SublimeGo() {
  WinActivate, ahk_class PX_WINDOW_CLASS
}

ExitChessMonster() {
  gui hide
  SublimeGo()
  ExitApp
}

;======= KEYBOARD SHORTCUTS ===================

^+z::Pause           ; ctrl + shift + z
;^+x::ExitApp            ; ctrl + shift + x
^x::ExitChessMonster() ; ctrl + shift + x
^+x::ExitChessMonster() ; ctrl + shift + x
; ^+c::SublimeGo() ; ctrl + shift + x

1::NewGame()
2::MakeMove()
7::DriftMouse()
r::RematchComputer()
q::MoveGui1()
e::MoveGui2()
s::ShakeGui()
; 0::UpdatePosition("e5")
; 0::SqStatTest()

a::GetPositions()
w::MyColorWhite()
b::MyColorBlack()

z::SoundBeep, 400, 500  ; , [ Frequency, Duration]

;9::OutputDebug, % "Output Debug Output Debug" . my_color . ""
