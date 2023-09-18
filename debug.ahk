;debug.ahk
;
global bug_path := rel_path . "debug.txt"

DebugRefresh()

DebugRefresh() {
  filedelete % bug_path
  fileappend debug.txt `n `n , % bug_path
}

Debug(debug_text) {
  debug_text := "---------`n" . debug_text
  fileappend % debug_text, % bug_path
}

DoNothing() {
  nothing := "nothing"
  return nothing
}