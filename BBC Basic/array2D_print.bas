10 REM
11 REM Alokace pole 4x5 prvku
12 REM
20 DIM A(3,4)
30 PRINT DIM(A())
40 REM
41 REM Naplneni prvku pole
42 REM
50 FOR J=0 TO DIM(A(),2)
51   FOR I=0 TO DIM(A(),1)
52     A(I,J) = I*J
53   NEXT I
54 NEXT J
60 REM
61 REM Vypis obsahu pole
62 REM
70 FOR J=0 TO DIM(A(),2)
71   FOR I=0 TO DIM(A(),1)
72     PRINT A(I,J);
73   NEXT I
74   PRINT
75 NEXT J
