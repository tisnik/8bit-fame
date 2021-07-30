1 ------------------------------
2 REM Usage of PRINT statement
3 REM to print data to given I/O
4 REM channel via CIO
5 REM beware of comma in PRINT
6 ------------------------------
10 OPEN #1,8,0,"H:DATA.TXT"
11 PRINT #1,"HELLO WORLD!"
12 CLOSE #1
999 END 
