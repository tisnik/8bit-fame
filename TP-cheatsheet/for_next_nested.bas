1 ------------------------------
2 REM Nested FOR-NEXT statements
3 ------------------------------
10 FOR I=1 TO 10
20   FOR J=1 TO 10
30     X=I*J
40     PRINT X;" ";
50     IF X<10 THEN PRINT " ";
60   NEXT J
70   PRINT 
80 NEXT I
998 REM finito
999 STOP
