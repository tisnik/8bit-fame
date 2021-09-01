1 REM *****************************
2 REM Test presnosti vypoctu v FP
3 REM 
4 REM Uprava pro BASIC XE
5 REM 
6 REM *****************************
7 REM
8 REM
9 REM
10 H1=0
11 H2=0
12 N=1
20 H2=H1+1/N
21 IF H1=H2 THEN END 
22 PRINT N;" ";H1;" ";H2
23 H1=H2
24 N=N+1
30 GOTO 20
