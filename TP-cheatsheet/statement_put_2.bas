1 ------------------------------
2 REM Basic usage of PUT I/O
3 REM statement for value greater
4 REM than 255
5 ------------------------------
10 CLOSE #1
11 OPEN #1,8,0,"H:BYTE2.BIN"
12 PUT #1,300
13 CLOSE #1
999 END 
