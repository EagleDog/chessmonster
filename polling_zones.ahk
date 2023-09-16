;polling_zones.ahk
;
;
global period := "early"

zone_1 := ["d5","e5","d6","e6","c5","f5","c6","f6"]  ; opp_center
zone_2 := ["a6","h6"]
zone_3 := ["d4","e4","c4","f4"]  ; opp_front
zone_4 := ["a5","h5","a7","h7","c8","f8","b8","g8"] ; backfield manuevers
zone_5 := ["d3","e3","c3","f3"]  ; opp_deep_front
zone_6 := ["d5","e5","d4","e4"]  ; main_small_center
zone_7 := ["b7","g7"]  ; snipers
zone_8 := ["a5","h5","a3","h3","a4","h4","a6","h6"] ; sidebars
zone_9 := ["b5","g5","a8","h8","c7","f7","b6","g6","d8","e8","b4","g4"] ; neglected_squares

zone_12 := CombineArrays(zone_1, zone_2)
zone_13 := CombineArrays(zone_1, zone_3)
zone_24 := CombineArrays(zone_2, zone_4)
zone_62 := CombineArrays(zone_6, zone_2)
zone_135 := CombineArrays(zone_1, zone_3, zone_5)
zone_235 := CombineArrays(zone_2, zone_3, zone_5)
zone_1358 := CombineArrays(zone_1, zone_3, zone_5, zone_8)

global zones := {  zone_1: zone_1, zone_2: zone_2, zone_3: zone_3
                 , zone_4: zone_4, zone_5: zone_5, zone_6: zone_6
                 , zone_7: zone_7, zone_8: zone_8, zone_9: zone_9
                 , zone_12: zone_12, zone_13: zone_13, zone_24: zone_24
                 , zone_62: zone_62, zone_135: zone_135, zone_235: zone_235
                 , zone_1358: zone_1358 }



WhichPeriod() {
  if ( move_num < 13 ) {
    period := "early"
  } else if ( move_num < 25 ) {
    period := "midgame"
    } else {
    period := "endgame"
  }
}

WhichPolls() {
  if ( period == "early" ) {
;    zone_1
;    zone_2
  } else if ( period == "midgame" ) {
;    zone_3
;    zone_7
  } else {
;    zone_135
  }
}

PollZones(zones) {

}

PollZone(zone) {
;  LogMain("PollZone(" . zone . ")")
  n := 1
  while zone[n] {
    spot := zone[n]
    UpdatePosition(spot)
    n := A_Index + 1
;    sleep 200
  }

}


CombineArrays(array_1, array_2, array_3="", array_4="", array_5="", array_6="", array_7="") {
  source_arrays := [array_1, array_2, array_3, array_4, array_5, array_6, array_7]
  new_array := []
  n := 1
    while source_arrays[n] {
      active_array := source_arrays[n]
      n:= A_Index + 1
      nn:= 1
      while active_array[nn] {
        new_array.Push(active_array[nn])
        nn := A_Index + 1
      }
    }
  return new_array
  ; array_text := ReadArray(new_Array)
  ; msgbox % array_text
}

ReadArray(arr) {
  array_contents := ""
  n := 1
  while arr[n] {
    array_contents := array_contents . arr[n] . " "
    n := A_Index + 1
  }
  return array_contents
}

; ^+x::ExitApp
; 0::msgbox % ReadArray(CombineArrays(zone_1, zone_2, zone_3))
;9::PollZone(zone_1)