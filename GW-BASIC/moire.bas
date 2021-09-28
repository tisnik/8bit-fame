1 REM *****************************
2 REM Circle moire
3 REM v grafickem rezimu 7 (16 barev)
4 REM 
5 REM Uprava pro GW-BASIC
6 REM
7 REM *****************************
8 REM
9 REM
10 SCREEN 7
20 FOR Y=0 TO 349
30   FOR X=0 TO 639
40     C=INT(X*X/40+Y*Y/40)
50     PSET (X, Y), C MOD 16
80   NEXT X
90 NEXT Y
999 END
