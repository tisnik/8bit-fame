10 REM
11 REM Alokace pole 5x6x7 prvku
12 REM
20 DIM A(4,5,6)
30 PRINT DIM(A())
40 REM
41 REM Vypis velikosti pole v kazde dimenzi
42 REM
50 FOR D=1 TO DIM(A())
60   PRINT D,DIM(A(),D)
70 NEXT D
