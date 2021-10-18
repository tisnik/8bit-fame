rem *****************************
rem Výpočet faktoriálu
rem 
rem Úprava pro Basic-256
rem
rem Použití podprogramu.
rem 
rem *****************************

for n=1 to 20
    call factorial(n)
next n
end 

rem *****************************
rem Výpočet faktoriálu
rem *****************************

subroutine factorial(n)
    fact=1
    for i=n to 1 step -1
        fact=fact*i
    next i
    print fact
end subroutine
