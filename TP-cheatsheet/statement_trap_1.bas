1 ------------------------------
2 REM Read one byte from file
3 REM via CIO operation GET
4 REM with error handling
5 ------------------------------
10 CLOSE #1
11 TRAP 1000
12 OPEN #1,4,0,"H:FOO.BIN"
13 GET #1,B
14 PRINT B
15 CLOSE #1
998 REM finito
999 STOP
1000 ------------------------------
1001 REM I/O error handler
1002 ------------------------------
1003 ERR=PEEK(195)
1004 PRINT "I/O ERROR #";ERR
1005 CLOSE #1
