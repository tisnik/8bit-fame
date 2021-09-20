1 REM *****************************
2 REM Příkaz ON GOSUB
3 REM 
4 REM Uprava pro GW-BASIC
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 PRINT "1. File operations"
20 PRINT "2. Edit operations"
30 PRINT "3. Quit"
40 INPUT A
50 ON A GOSUB 1000, 2000, 3000
60 GOTO 10
999 END 
1000 PRINT "File operations"
1010 RETURN
2000 PRINT "Edit operations"
2010 RETURN
3000 PRINT "Quit"
3010 RETURN
