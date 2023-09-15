;polling_zones.ahk
;
;
;


zone_1 := ["d5","e5","d6","e6","c5","f5","c6","f6"]
zone_2 := ["a6","h6"]
zone_3 := ["d4","e4","c4","f4"]
zone_4 := ["a5","h5","a7","h7","c8","f8","b8","g8"]
zone_5 := ["d3","e3","c3","f3"]
zone_6 := ["d5","e5","d4","e4"]  ; main small center
zone_7 := ["b7","g7"]  ; snipers
zone_8 := ["a5","h5","a3","h3","a4","h4","a6","h6"] ; sidebars
zone_9 := ["b5","g5","a8","h8","c7","f7","b6","g6","d8","e8","b4","g4"]

polling_zones := { zone_1: zone_1, zone_2: zone_2, zone_3: zone_3, zone_4: zone_4, zone_5: zone_5, zone_6: zone_6, zone_7: zone_7, zone_8: zone_8, zone_9: zone_9 }

blank_array := ["a","b"]
CombineArrays(array_1, array_2) { ;, array_3=blank_array, array_3=blank_array, array_4=blank_array, array_5=blank_array, array_6=blank_array, array_7=blank_array)
  new_array = []
  n := 1
  while array_1[n] {
    n := A_Index
    new_array.push(array_1[n])
  }

}

generic_array := ["dog","cat","mouse"]

ForEach(arr) {
  output_text := ""
  n := 1
  while arr[n] {
    n := A_Index
    output_text := output_text . arr[n] . " "
  }
  msgbox % output_text
}

^+x::ExitApp
0::ForEach(generic_array)