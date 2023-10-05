;ChessMonster
; resolution: HP second screen
; browser zoom: 80%
; board_scope := "147, 205  to  849, 908" ;(702 x 761 )
; square_size := "87 by 95"  ;87 x 87

; Exit
; Pause On

global rel_path := A_ScriptDir
global assets_path := rel_path "\assets\"
global fishlog := rel_path "\engine\fishlog.txt"

#Include includer.ahk

;global none := "none"
global my_color := "white"
global opp_color := "black"
global my_color_abbr := "w"

global paused := false

global move_num := 1

MainSequence()

;
;    ====== MAIN SEQUENCE ===================

MainSequence() {
  ActivateChess()
  ; CreateGui()
  CreateBoard()
  StartEngine()
  GetStartingPositions()
  ResetSnapshots()
  ; DidGameEnd()
}

;
;   ======= NEW GAME ========================

NewGame() {
;  ActivateChess()
;  ScrollUp()
  GetMyColor()
  ResetMoves()
  ResetCastleRights()
  GetStartingPositions()
  ResetSnapshots()
  NewGameUCI()
  ClearLogFields()
  sleep 1000
  GetMyColor()
  FailSafe()
  StartGame()
}

StartGame() {
  GetMyColor()
  if ( my_color == "black" ) {
    PollOpp()
  }
  ; GetPositions()
  RunUCI()
  PollOpp()
}

ActivateChess() {
  SetTitleMatchMode, 2
  if WinExist("Chess Online") {
    WinActivate, Chess Online
  }
}

SublimeGo() {
  WinActivate, ahk_class PX_WINDOW_CLASS
}

ExitChessMonster() {
  gui hide
  SublimeGo()
  ExitStreamer()
;  ShowCursor()
  ExitApp
}


;======= KEYBOARD SHORTCUTS ===================


^+z::Pause           ; ctrl + shift + z
;^+x::ExitApp            ; ctrl + shift + x
^x::ExitChessMonster() ; ctrl + shift + x
^+x::ExitChessMonster() ; ctrl + shift + x
; ^+c::SublimeGo() ; ctrl + shift + x

1::StartGame()
;1::CheckBackField()
;1::DidGameEnd()
;2::StartGame()
5::PollOpp()
;2::PollOpp()
3::RunUCI()

4::SearchSuccessors("d4", rook_patterns)
; 4::SearchSuccessors("h8", rook_patterns)

8::UndoPremove("a1", "b1")


c::ColorTest()



;5::CheckPawnSize()

9::msgbox % move_num "--move_num"
0::NewGameUCI()

^1::NewGame()
^2::GoLoop()
^3::MoveGui3()

r::RematchSequence(10)

m::DriftMouse()
q::MoveGui1()
e::MoveGui2()
s::ShakeGui()

;9::New3Min()

d::DebugSnapshots()

;0::CheckQueenAntecedents("e5")
;0::OutputSnapshot(1)
;0::GetPositionsHistory(2)

a::GetPositions("fast")
^a::GetPositions("slow")
^+a::GetPositions("slow")
w::MyColorIsWhite()
b::MyColorIsBlack()

p::PauseMatch()

o::OutputSnapshot()

Up::IncreaseMoveNum()
Down::DecreaseMoveNum()

z::Beep()
