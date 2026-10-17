' BUBBLE SORT
' IMPLEMENTACE PRO TURBO-BASIC XL
' 
' ----------------------------

' ------------------------------
' VYMAZANI CASOVACE
' ------------------------------
POKE 18,0
POKE 19,0
POKE 20,0

MAX=50
DIM A(MAX)
FOR I=0 TO MAX
    A(I)=RAND(100)
NEXT I
EXEC PRINT_ARRAY
FOR I=MAX-1 TO 0 STEP -1
    PRINT ".";
    FOR J=0 TO I
        IF A(J)<A(J+1)
             X=A(J):A(J)=A(J+1):A(J+1)=X
        ENDIF 
    NEXT J
NEXT I
PRINT ""
PRINT "SORTED:"
EXEC PRINT_ARRAY

' ------------------------------
' PRECTENI CASOVACE
' (PLATNE PRO PAL)
' ------------------------------
T%=PEEK(19)*256+PEEK(20)
T%=T%/50
PRINT "FINISHED IN ";T%;" SECONDS"

' ------------------------------
' KONEC
' ------------------------------
DO
LOOP

' ------------------------------
' TISK OBSAHU POLE
' ------------------------------
PROC PRINT_ARRAY
  FOR I=0 TO MAX
    PRINT I,A(I)
  NEXT I
ENDPROC 

