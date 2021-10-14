' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Kreslení s využitím želví grafiky

Turtle.Show()
Turtle.Hide()
Turtle.Speed = 10

vertexes = 9

for i = 1 to vertexes
    Turtle.Turn(360*2/vertexes)
    Turtle.Move(100)
endfor
