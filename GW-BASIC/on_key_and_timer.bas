1 REM *****************************
2 REM Ukázka pouziti vice handleru
3 REM 
4 REM Uprava pro GW-BASIC
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 KEY 15, CHR$(0) + CHR$(1)
20 ON KEY(15) GOSUB 1000
30 ON TIMER(1) GOSUB 2000
40 PRINT "Waiting for user input and timer ticks..."
50 TIMER ON
80 KEY (15) ON
90 GOTO 90
999 END 
1000 REM
1001 REM prvni handler
1002 REM
1003 PRINT "stlacena klavesa Esc"
1004 RETURN
2000 REM
2001 REM druhy handler
2002 REM
2003 PRINT "tick"
2004 RETURN
