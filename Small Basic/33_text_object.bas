' Použito v článku
'
' Vestavěné objekty Small Basicu: práce s grafikou, časovačem, reakce na události
' https://www.root.cz/clanky/vestavene-objekty-small-basicu-prace-s-grafikou-casovacem-reakce-na-udalosti/

' Základní operace s řetězci realizovaná přes objekt Text

message = "Hello, world"
TextWindow.WriteLine(message)

message = Text.Append(message, "!")
TextWindow.WriteLine(message)

TextWindow.WriteLine(Text.ConvertToUpperCase(message))

TextWindow.WriteLine(Text.GetSubText(message, 8, 5))
