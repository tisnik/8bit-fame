1 REM *****************************
2 REM Prace s dvourozmernymi poli
3 REM 
4 REM Uprava pro BASIC XE
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 DIM M(5,5)
15 FOR I=0 TO 5
20 FOR J=0 TO 5
25 M(I,J)=I*J
30 NEXT J
35 NEXT I
40 REM TISK POLE
45 FOR I=0 TO 5
50 FOR J=0 TO 5
55 PRINT M(I,J),
60 NEXT J
65 PRINT 
70 NEXT I
999 END 
