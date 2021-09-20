1 REM *****************************
2 REM Ukázka handleru klavesnice
3 REM 
4 REM Uprava pro GW-BASIC
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 KEY 15, CHR$(0) + CHR$(1)
20 ON KEY(15) GOSUB 1000
30 PRINT "Waiting for user input..."
40 KEY (15) ON
50 GOTO 50
999 END 
1000 REM
1001 REM handler
1002 REM
1003 PRINT "stlacena klavesa Esc"
1004 RETURN
