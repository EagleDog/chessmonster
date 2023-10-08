;uci_support.ahk
;
;

AdjustElo() {
  SendToUCI("setoption name UCI_LimitStrength value true")
  SendToUCI("setoption name UCI_Elo value " elo)
}

RandMoveTime(){
  random rand_move_time, 800, 1200
  return rand_move_time
}


