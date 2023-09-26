;zone_poller.ahk
;
;
global period := "opening"
global which_zone := 1

;____zones____
global z1 := ["c5","d5","e5","f5","c6","d6","e6","f6"]  ; opp_front
global z2 := ["a5","b5","g5","h5","a6","b6","g6","h6"]  ; opp_sides
global z3 := ["a7","b7","g7","h7","a8","b8","g8","h8"]  ; opp_corners
global z4 := ["c7","d7","e7","f7","c8","d8","e8","f8"] ; opp_rear
global z5 := ["c3","d3","e3","f3","c4","d4","e4","f4"]  ; my_front
global z6 := ["a3","b3","g3","h3","a4","b4","g4","h4"]  ; my_sides
global z7 := ["a1","b1","g1","h1","a2","b2","g2","h2"]  ; my_corners
global z8 := ["c1","d1","e1","f1","c2","d2","e2","f2"] ; my_rear

global zones := [ z1, z2, z3, z4, z5, z6, z7, z8 ]

PollZones() { ; find last opp_move only
  loop 8 {
    zone := zones[which_zone]
    opp_move := PollZone(zone)
    if ( opp_move == true ) {
      return
    }
    which_zone += 1
    if ( which_zone > zones.count() ) {
      LogDebug(zones.count())
      which_zone := 1
    }
  }
}

PollZone(zone) {
  LogTimer("PollZone(" . which_zone . ")")
  n := 1
  while zone[n] {
    spot := zone[n]
    color := UpdatePosition(spot)
    if ( color != my_color ) {
      if DidSquareChange(spot) {
        CheckAntecedents(spot)
        return true
      }
    }
    n := A_Index + 1
  }
}

SearchZones(zone) { ; search many positions for
  loop 8 {          ;   starting mid-game
    zone := zones[which_zone]
    PollZone(zone)
    which_zone += 1
    if ( which_zone > zones.count() ) {
      LogDebug(zones.count())
      which_zone := 1
    }
  }
}

WhichZones() {
  if ( move_num < 50 ) {
    zones := [ z1, z2, z3, z4, z5, z6, z7, z8 ]
  } else if ( move_num < 5 ) {
    period := "opening"
    zones := [ z1, z2 ]
  } else if ( move_num < 9 ) {
    period := "opening"
    zones := [ z1, z2, z5, z1, z2, z6 ]
  } else if ( move_num < 13 ) {
    period := "early game"
    zones := [ z1, z2, z5, z1, z2, z6 ]
  } else if ( move_num < 17 ) {
    period := "early game"
    zones := [ z1, z2, z5, z1, z2, z6, z1, z2, z3, z1, z2, z4 ]
  } else if ( move_num < 23 ) {
    period := "mid game"
    zones := [ z1, z2, z5, z1, z2, z6, z1, z2, z3, z1, z2, z4 ]
  } else if ( move_num < 31 ) {
    period := "mid game"
    zones := [ z1, z2, z5, z1, z2, z6, z1, z2, z3, z1, z2, z4 ]
  } else if ( move_num < 37 ) {
    period := "end game"
    zones := [ z1, z2, z5, z1, z2, z6, z1, z2, z3, z1, z2, z4 ]
  } else {
    period := "end game"
    zones := [ z1, z2, z5, z1, z6, z2, z3, z1, z4, z2, z7, z1, z2, z8 ]
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

