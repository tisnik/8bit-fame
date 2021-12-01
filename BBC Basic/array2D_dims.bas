10 REM
11 REM Alokace pole 4x5 prvku
12 REM
20 DIM A(3,4)
30 PRINT DIM(A())
40 REM
41 REM Vypis velikosti pole v kazde dimenzi
42 REM
50 FOR D=1 TO DIM(A())
60   PRINT D,DIM(A(),D)
70 NEXT D
