' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Grafický výstup

GraphicsWindow.Show()
GraphicsWindow.BackgroundColor = GraphicsWindow.GetColorFromRGB(0,0,0)

GraphicsWindow.PenColor = GraphicsWindow.GetColorFromRGB(255, 0, 0)
GraphicsWindow.DrawRectangle(10, 10, 100, 100)

GraphicsWindow.PenColor = GraphicsWindow.GetColorFromRGB(0, 0, 255)
GraphicsWindow.DrawLine(60, 50, 60, 70)
GraphicsWindow.DrawLine(50, 60, 70, 60)
