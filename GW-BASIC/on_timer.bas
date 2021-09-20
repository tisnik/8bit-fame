1 REM *****************************
2 REM Ukázka handleru udalosti
3 REM 
4 REM Uprava pro GW-BASIC
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 ON TIMER(1) GOSUB 1000
20 PRINT "Waiting for timer ticks..."
30 TIMER ON
40 GOTO 30
999 END 
1000 REM
1001 REM handler
1002 REM
1003 PRINT "tick"
1004 RETURN
