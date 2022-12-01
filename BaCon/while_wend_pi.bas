REM *****************************
REM 
REM Výpočet hodnoty konstanty PI
REM postavený na smyčce
REM typu WHILE-WEND.
REM 
REM Uprava pro BaCon
REM *****************************


N=1
WHILE N<=2000
    GOSUB COMPUTE_PI
    PRINT N," ", PI_VAL
    N=N*2
WEND 

REM SUBRUTINA PRO VYPOCET PI
LABEL COMPUTE_PI
    PI_VAL=4.0
    J=3
    WHILE J<=N+2
        PI_VAL=PI_VAL*(J-1)/J*(J+1)/J
        J=J+2
    WEND 
RETURN
