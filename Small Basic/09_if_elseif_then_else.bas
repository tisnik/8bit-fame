TextWindow.Write("Circle radius = ")
r = TextWindow.ReadNumber()

if r < 0 then
    TextWindow.WriteLine("Negative radius?!")
elseif r = 0 then
    TextWindow.WriteLine("Zero radius -> zero area")
else
    area = Math.Pi * r * r
    TextWindow.WriteLine("Circle area = " + area)
endif
