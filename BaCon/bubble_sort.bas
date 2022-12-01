REM *****************************
REM 
REM Bubble sort
REM 
REM Uprava pro BaCon
REM 
REM *****************************



GLOBAL A[20]

FOR I=0 TO 20
    A[I]=INT(RANDOM(100))
NEXT I

GOSUB PRINT_ARRAY

FOR I=19 TO 0 STEP -1
    PRINT ".";
    FOR J=0 TO I
        IF A[J]>A[J+1] THEN
            X=A[J]
            A[J]=A[J+1]
            A[J+1]=X
        END IF
    NEXT J
NEXT I

PRINT ""
PRINT "SORTED:"

GOSUB PRINT_ARRAY
END

LABEL PRINT_ARRAY
REM TISK OBSAHU POLE
FOR I=0 TO 20
    PRINT I," ", A[I]
NEXT I
RETURN 
