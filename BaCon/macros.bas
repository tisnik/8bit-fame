REM *****************************
REM 
REM Bubble sort
REM 
REM Uprava pro BaCon
REM 
REM *****************************

#define dim GLOBAL
#define for FOR
#define to TO
#define next NEXT
#define gosub GOSUB
#define return RETURN
#define print PRINT
#define if IF
#define then THEN
#define end END


dim A[20]

for I=0 to 20
    A[I]=INT(RANDOM(100))
next I

gosub PRINT_ARRAY

for I=19 TO 0 STEP -1
    print ".";
    for J=0 to I
        if A[J]>A[J+1] then
            X=A[J]
            A[J]=A[J+1]
            A[J+1]=X
        end if
    next J
next I

print ""
print "SORTED:"

gosub PRINT_ARRAY
end

LABEL PRINT_ARRAY
REM TISK OBSAHU POLE
for I=0 TO 20
    print I," ", A[I]
next I
return 
