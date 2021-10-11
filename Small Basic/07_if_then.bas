TextWindow.Write("Circle radius = ")
r = TextWindow.ReadNumber()

if r < 0 then
    TextWindow.WriteLine("Negative radius?!")
endif

area = Math.Pi * r * r

TextWindow.WriteLine("Circle area = " + area)
