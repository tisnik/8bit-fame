1 ------------------------------
2 REM Nested REPEAT-UNTIL loops
3 ------------------------------
10 A=1
20 REPEAT 
30   B=10
40   REPEAT 
50     PRINT A*B;" ";
60     B=B+1
70   UNTIL B>20
80   A=A+1
90   PRINT 
95 UNTIL A>6
999 STOP
