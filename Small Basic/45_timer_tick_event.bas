' Události

Timer.Interval = 1000
Timer.Tick = OnTick
 
Sub OnTick
  TextWindow.WriteLine(Clock.Date + " " + Clock.Time)
EndSub