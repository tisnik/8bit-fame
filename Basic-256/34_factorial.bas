rem *****************************
rem Výpočet faktoriálu
rem 
rem Úprava pro Basic-256
rem
rem Použití programové konstrukce
rem GOSUB-RETURN
rem 
rem *****************************

for n=1 to 20
    gosub FACTORIAL
    print fact
next n
end 

rem *****************************
rem Výpočet faktoriálu
rem *****************************

FACTORIAL:
    fact=1
    for i=n to 1 step -1
        fact=fact*i
    next i
    return 
