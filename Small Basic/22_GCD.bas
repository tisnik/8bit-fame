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
