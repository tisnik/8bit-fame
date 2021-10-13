' Použito v článku
'
' Small Basic: moderní reinkarnace BASICu určená pro výuku programování
' https://www.root.cz/clanky/small-basic-moderni-reinkarnace-basicu-urcena-pro-vyuku-programovani/

TextWindow.Write("Circle radius = ")
r = TextWindow.ReadNumber()

if r < 0 then
    TextWindow.WriteLine("Negative radius?!")
else
    if r = 0 then
        TextWindow.WriteLine("Zero radius -> zero area")
    else
        area = Math.Pi * r * r
        TextWindow.WriteLine("Circle area = " + area)
    endif
endif
