1 ------------------------------
2 REM Usage of PRINT statement
3 REM to print data to channel 1
4 REM which is opened in
5 REM read-only mode.
6 ------------------------------
10 OPEN #1,4,0,"H:DATA.TXT"
11 PRINT #1,"HELLO WORLD!"
12 CLOSE #1
999 END 
