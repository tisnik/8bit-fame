1 ------------------------------
2 REM Greatest common divisor
3 REM (GCD) computation based on
3 REM WHILE loop.
4 ------------------------------
10 PRINT "X=";
20 INPUT X
30 PRINT "Y=";
40 INPUT Y
50 WHILE X<>Y
60   IF X>Y
61     X=X-Y
63   ENDIF 
70   IF X<Y
71     Y=Y-X
73   ENDIF 
80 WEND 
90 PRINT "GCD: ";X
998 REM finito
999 STOP
