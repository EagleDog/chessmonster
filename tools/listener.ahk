;listentest.ahk
 ;script adapted from original by Tab Nation Automation (YouYube)
 ;VA library is by Lexikos

 
;#Include VA.ahk
;#SingleInstance, Force
;Return
 
Listen() {
  sleep 200
  LogField2("--")
  ; LogMain("listening")
  peakValue := 0.01
  triggerVol := 0.00001
  audioMeter := VA_GetAudioMeter()

  timer_count := 0.00
  timer_text := "0:" . timer_count
  LogField3(timer_text)
  VA_IAudioMeterInformation_GetMeteringChannelCount(audioMeter, channelCount)
  VA_GetDevicePeriod("capture", devicePeriod)

  loop {
    timer_text := "0:" . timer_count
    LogField3(timer_text)
    VA_IAudioMeterInformation_GetPeakValue(audioMeter, peakValue)
    if (peakValue > triggervol) {
;      LogField4("volume: " . peakValue)
;      LogField2(" sound detected ")
      return
    }
    sleep 100
    timer_count += 100/1000
    if (timer_count > 3) {
;      LogField2("timeout")
;      LogField4(0.000)
;      CheckForGameEnd(old)
      return
    }
  }
}
