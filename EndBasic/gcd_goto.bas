PRINT "X=";
INPUT X
PRINT "Y=";
INPUT Y
REM "Vypocet"

@loop
IF X=Y THEN
    PRINT "GCD:"; X
END IF
IF X>Y THEN
    X=X-Y
    GOTO @loop
END IF
IF X<Y THEN
    Y=Y-X
    GOTO @loop
END IF
