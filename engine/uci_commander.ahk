;uci_sequence.ahk
;
; 
; STEP 0 -- launch stockfish console    DONE
; STEP 1 -- ucinewgame                  DONE
; STEP 2 -- position startpos           DONE
; STEP 3 -- isready                     DONE
; STEP 4 -- go movetime 1000            DONE
; STEP 5 -- stop
; STEP 6 -- get bestmove (e.g. e2e3)    DONE
; STEP 7 -- translate move to gui (e.g. MovePiece(e2,e3))   DONE
; STEP 8 -- get new fen from gui
; STEP 9 -- position fen rnbqk3/4pppp/8/8/...etc  (reflects move e2e3)
; STEP 10 -- is ready
; STEP 11 -- go movetime 1000
; ... etc.

; need to convert positions to FEN and vice versa (good progress so far)


;#include streamer.ahk
global bestmove := ""
global bestmoves := []
global move_time := 500


stockfish_commands := ["ucinewgame","isready","d","position startpos"
                       ,"position fen","go movetime 1000", "stop", "flip"]

DispatchUciCommands() {
  AttachStockfish()
  sleep 100
  NewGameUci()
  sleep 100
  StartPos()
  sleep 100
  SendIsReady()
  sleep 100
  GetIsReady()
  sleep 100
  CalculateMove(move_time)
   bestmove := GetBestMove()
   bestmoves := ParseBestMove(bestmove)
  ActivateChess()
  SendMoveToGUI(bestmoves)
  GetFenFromGUI()
  SendNewPosition()

}

GetIsReady() {
  ready_response := ReceiveReady()
  while ( ready_response != "readyok") {
    ready_response := ReceiveReady()
  }
}

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

NewGameUci() {      ; function name conflict
  SendCommand("ucinewgame")
}

StartPos() {
  SendCommand("position startpos")
}

SendIsReady() {
  SendCommand("isready")
}

CalculateMove(movetime) {
  SendCommand("go movetime " movetime)
}

StopThinking() {
  SendCommand("stop")
}

DisplayBoard() {
  SendCommand("d")
}

FlipBoardUci() {    ; function name conflict
  SendCommand("flip")
}

ReceiveReady() {
  ready_response := ReceiveResponse()
  FileAppend % ready_response " ", *
  return ready_response
}
GetBestMove() {
  response := ReceiveResponse()
  bestmove := StrSplit(response, " ")[2]
  FileAppend % bestmove " ", *
  return bestmove
}

ParseBestMove(bestmove) {
  bestmoves := []
  loop parse, bestmove
  { 
    if A_LoopField is Integer
    {
      num_pos := A_Index
      bestmoves.push(SubStr(bestmove, num_pos - 1, 2))
    }
  }
  return bestmoves
}

SendMoveToGUI(bestmoves) {
;  MovePiece(bestmoves[1], bestmoves[2])
  fileappend % "bestmove: " bestmoves[1] " " bestmoves[2] " ", *
}
GetFenFromGUI() {

}
SendNewPosition() {

}

; 1::AttachConsole()
; 2::NewGameUci()
; 3::StartPos()
; 4::SendIsReady()
; 5::ReceiveReady()

; 6::CalculateMove(500)
; 7::GetBestMove()
; 8::ParseBestMove(bestmove)
; 9::SendMoveToGUI(bestmoves)
; ;9::GetFenFromGUI()
; 0::SendNewPosition()

; ;2::OutToFish("isready")
; ;3::InFromFish()

; ^+x::ExitStreamer()





