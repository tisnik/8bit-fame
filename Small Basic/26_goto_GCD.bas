' *****************************
' Vypocet nejvetsiho spolecneho
' delitele.
' 
' Uprava pro Small Basic
' 
' *****************************
'
'

TextWindow.Write("X = ")
x = TextWindow.ReadNumber()

TextWindow.Write("Y = ")
y = TextWindow.ReadNumber()

LOOP:
if x = y then
    TextWindow.WriteLine("GCD = " + x)
    goto END
endif

if x > y then
    x = x -y
    goto LOOP
endif

if x < y then
    y = y -x
    goto LOOP
endif

END:
