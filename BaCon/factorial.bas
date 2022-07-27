REM *****************************
REM 
REM Vypocet faktorialu
REM 
REM Uprava pro BaCon
REM 
REM *****************************

FOR N=0 TO 20
    GOSUB FACTORIAL
    PRINT N," ",FACT
NEXT N
END 

REM VYPOCET FAKTORIALU
LABEL FACTORIAL
FACT=1
FOR I=N TO 1 STEP -1
    FACT=FACT*I
NEXT I
RETURN 
