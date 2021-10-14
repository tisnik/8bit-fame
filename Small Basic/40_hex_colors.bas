' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Grafický výstup

GraphicsWindow.Show()
GraphicsWindow.BackgroundColor = "#000000"

GraphicsWindow.PenColor = "#80ffff"
GraphicsWindow.DrawRectangle(10, 10, 100, 100)

GraphicsWindow.PenColor = "#ffff80"
GraphicsWindow.DrawLine(60, 50, 60, 70)
GraphicsWindow.DrawLine(50, 60, 70, 60)
