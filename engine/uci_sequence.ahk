;uci_sequence.ahk
;

; STEP 1 -- ucinewgame 
; STEP 2 -- position startpos
; STEP 3 -- isready
; STEP 4 -- go movetime 1000
; STEP 5 -- stop
; STEP 6 -- get bestmove (e.g. e2e3)
; STEP 7 -- translate move to gui (e.g. MovePiece(e2,e3))
; STEP 8 -- get new fen from gui
; STEP 9 -- position fen rnbqk3/4pppp/8/8/...etc  (reflects move e2e3)
; STEP 10 -- is ready
; STEP 11 -- go movetime 1000
; ... etc.

; need to convert positions to FEN and vice versa (good progress so far)


#include streamer.ahk

stockfish_commands := ["ucinewgame","isready","d","position startpos"
                       ,"position fen","go movetime 1000", "stop", "flip"]





AttachConsole() {
  AttachStockfish()
}

SendCommand(command) {
  OutToFish(command)
}

ReceiveResponse() {
  response := InFromFish()
  return response
}

NewGame() {      ; function name conflict
  SendCommand("ucinewgame")
}

StartPos() {
  SendCommand("position startpos")
}
IsReady() {
  SendCommand("isready")
}
GoTime() {
  SendCommand("go movetime 1000")
}
StopThinking() {
  SendCommand("stop")
}
DisplayBoard() {
  SendCommand("d")
}
FlipBoard() {    ; function name conflict
  SendCommand("flip")
}

ReceiveReady() {
  response := ReceiveResponse()
  FileAppend % response, *
}
GetBestMove() {
  response := ReceiveResponse()
  bestmove := response
  FileAppend % bestmove, *
}
SendMoveToGUI() {

}
GetGUIPosition() {

}
SendNewPosition() {

}

1::AttachConsole()
2::NewGame()
3::StartPos()
4::IsReady()
5::ReceiveReady()

6::GoTime()
7::GetBestMove()
8::SendMoveToGUI()
9::GetGUIPosition()
0::SendNewPosition()

;2::OutToFish("isready")
;3::InFromFish()

^+x::ExitSequence()





