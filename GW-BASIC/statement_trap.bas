1 REM *****************************
2 REM Ukázka reakce na chybu
3 REM 
4 REM Uprava pro GW-BASIC
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 ON ERROR GOTO 1000
11 A = 10
12 PRINT A/0
999 END 
1000 REM
1001 REM error handler
1002 REM
1003 PRINT "Chyba na radku:"; ERL
1004 PRINT "Kod chyby:"; ERR
1005 RESUME NEXT
