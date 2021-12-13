1 ------------------------------
2 REM Basic usage of PUT I/O
3 REM statement
4 ------------------------------
10 CLOSE #1
11 OPEN #1,8,0,"H:BYTE1.BIN"
12 PUT #1,50
13 CLOSE #1
998 REM finito
999 STOP
