1 ------------------------------
2 REM Usage of CLOSE statement
3 REM to close the given I/O
4 REM channel via CIO
5 ------------------------------
10 OPEN #1,8,0,"H:DATA.TXT"
11 PRINT #1;"HELLO WORLD!"
12 CLOSE #1
999 END 
