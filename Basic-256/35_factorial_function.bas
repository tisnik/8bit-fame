rem *****************************
rem Výpočet faktoriálu
rem 
rem Úprava pro Basic-256
rem
rem Použití definované uživatelské
rem funkce
rem 
rem *****************************

for n=1 to 20
    print factorial(n)
next n
end 

rem *****************************
rem Výpočet faktoriálu
rem *****************************

function factorial(n)
    fact=1
    for i=n to 1 step -1
        fact=fact*i
    next i
    return fact
end function
