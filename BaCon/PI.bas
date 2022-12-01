REM *****************************
REM 
REM Vypocet konstanty Pi.
REM 
REM Uprava pro BaCon
REM 
REM *****************************

LOCAL N=1

FOR I=1 TO 10
    REM vypocet PI
    GOSUB PI_COMP
    PRINT "I=",I," N=",N," PI=", PI_VAL
    N=N*2
NEXT I
REM finito
END

REM *****************************
REM SUBRUTINA PRO VYPOCET PI
REM *****************************

LABEL PI_COMP
PI_VAL = 4.0
FOR J=3 TO N+2 STEP 2
    PI_VAL=PI_VAL*(J-1)/J*(J+1)/J
NEXT J
RETURN 
