;uci_support.ahk
;
;

AdjustElo() {
  SendToUCI("setoption name UCI_LimitStrength value true")
  SendToUCI("setoption name UCI_Elo value 310")
}

RandMoveTime(){
  random rand_move_time, 200, 800
  return rand_move_time
}


