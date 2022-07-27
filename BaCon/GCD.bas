REM *****************************
REM 
REM Vypocet nejvetsiho spolecneho
REM delitele.
REM 
REM Uprava pro BaCon
REM 
REM *****************************

PRINT "X=";
INPUT X
PRINT "Y=";
INPUT Y

LABEL LOOP

IF X=Y THEN
    PRINT "GCD: ";X
    STOP
END IF

IF X>Y THEN
    X=X-Y
    GOTO LOOP
END IF

IF X<Y THEN
     Y=Y-X
     GOTO LOOP
END IF
