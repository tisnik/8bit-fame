rem *****************************
rem Výpočet největšího společného
rem dělitele.
rem 
rem Úprava pro Basic-256
rem
rem Nekorektní název cíle skoku
rem *****************************
rem
rem

print "X = "
input x

print "Y = "
input y

LOOP:
if x = y then
    print x
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
