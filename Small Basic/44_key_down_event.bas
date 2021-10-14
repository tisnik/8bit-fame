' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Události

GraphicsWindow.KeyDown = OnKeyDown

Sub OnKeyDown
    key = GraphicsWindow.LastKey
    TextWindow.WriteLine(key)
EndSub
