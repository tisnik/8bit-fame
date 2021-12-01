10 REM
11 REM Alokace prvniho pole 5x2 prvku
12 REM
20 DIM A(4,1)
21 PRINT DIM(A())
30 REM
31 REM Naplneni prvku pole
32 REM
40 FOR J=0 TO DIM(A(),2)
41   FOR I=0 TO DIM(A(),1)
42     A(I,J) = I*J
43   NEXT I
44 NEXT J
50 REM
51 REM Alokace druheho pole 2x6 prvku
52 REM
60 DIM B(1,5)
61 PRINT DIM(B())
70 REM
71 REM Naplneni prvku pole
72 REM
80 FOR J=0 TO DIM(B(),2)
81   FOR I=0 TO DIM(B(),1)
82     B(I,J) = I*J
83   NEXT I
84 NEXT J
90 REM
92 REM Maticovy soucin
92 REM
90 DIM C(4,5)
91 C() = A().B()
92 REM
93 REM Vypis obsahu pole
94 REM
95 FOR J=0 TO DIM(C(),2)
96   FOR I=0 TO DIM(C(),1)
97     PRINT C(I,J);
98   NEXT I
99   PRINT
100 NEXT J
