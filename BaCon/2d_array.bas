REM *****************************
REM 
REM Prace s dvourozmernymi poli
REM 
REM Uprava pro BaCon
REM 
REM *****************************

LOCAL M[6][6]

FOR I=0 TO 5
    FOR J=0 TO 5
        M[I][J]=I*J
    NEXT J
NEXT I

REM TISK POLE
FOR I=0 TO 5
    FOR J=0 TO 5
        PRINT M[I][J], " ";
        NEXT J
    PRINT 
NEXT I
