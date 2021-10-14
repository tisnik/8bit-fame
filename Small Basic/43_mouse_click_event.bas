' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Události

GraphicsWindow.MouseDown = MouseClick

Sub MouseClick
    x = GraphicsWindow.MouseX
    y = GraphicsWindow.MouseY
    TextWindow.WriteLine("x: " + x + "   y: " +y)
EndSub
