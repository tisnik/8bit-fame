' Použito v článku
'
' Small Basic: moderní reinkarnace BASICu určená pro výuku programování
' https://www.root.cz/clanky/small-basic-moderni-reinkarnace-basicu-urcena-pro-vyuku-programovani/

' *****************************
' Výpočet největšího společného
' dělitele postavený na smyčce
' typu WHILE.
' 
' Úprava pro Small Basic
' *****************************

TextWindow.Write("X = ")
x = TextWindow.ReadNumber()

TextWindow.Write("Y = ")
y = TextWindow.ReadNumber()

while x<>y
    if x>y then
        x=x-y
    endif
    if x<y then
        y=y-x
    endif
endwhile

TextWindow.WriteLine("GCD = " + x)
