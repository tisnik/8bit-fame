1 ------------------------------
2 REM Usage of INPUT statement
3 REM to perform basic I/O
4 REM operations via CIO
5 ------------------------------
10 DIM A$(100)
11 OPEN #1,4,0,"H:DATA.TXT"
12 INPUT #1;A$
13 CLOSE #1
14 PRINT A$
999 END
