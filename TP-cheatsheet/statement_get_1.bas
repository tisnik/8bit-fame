1 ------------------------------
2 REM Read one byte from file
3 REM via CIO operation GET
4 ------------------------------
10 CLOSE #1
11 OPEN #1,4,0,"H:BYTE1.BIN"
12 GET #1,B
13 PRINT B
14 CLOSE #1
998 REM finito
999 STOP
