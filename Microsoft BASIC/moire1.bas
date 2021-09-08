1 REM *****************************
2 REM Circle moire
3 REM v grafickem rezimu 7
4 REM 
5 REM Uprava pro Microsoft BASIC
6 REM
7 REM *****************************
8 REM
9 REM
10 GRAPHICS 7
20 FOR Y=0 TO 79
30 FOR X=0 TO 159
40 C=INT(X*X/20+Y*Y/20)
50 COLOR C-INT(C/4)*4:REM NENI MODULO
60 PLOT X,Y
80 NEXT X
90 NEXT Y
999 END
