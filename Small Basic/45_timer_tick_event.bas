' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Události

Timer.Interval = 1000
Timer.Tick = OnTick
 
Sub OnTick
  TextWindow.WriteLine(Clock.Date + " " + Clock.Time)
EndSub
