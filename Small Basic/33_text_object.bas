' Základní operace s řetězci realizovaná přes objekt Text

message = "Hello, world"
TextWindow.WriteLine(message)

message = Text.Append(message, "!")
TextWindow.WriteLine(message)

TextWindow.WriteLine(Text.ConvertToUpperCase(message))

TextWindow.WriteLine(Text.GetSubText(message, 8, 5))