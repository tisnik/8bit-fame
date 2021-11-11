1 ------------------------------
2 REM ATN function computation
3 REM for selected input values
4 REM in DEG mode
5 ------------------------------
10 DEG 
20 RESTORE 100
30 FOR I=1 TO 7
40   READ X
50   PRINT X,ATN(X)
60 NEXT I
100 DATA -1E20, -1, -0.5
110 DATA 0
120 DATA 0.5, 1, 1E20
998 REM finito
999 STOP 
