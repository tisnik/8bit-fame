1 REM *****************************
2 REM Výpočet největšího společného
3 REM dělitele postavený na smyčce
4 REM typu WHILE-WEND.
5 REM 
6 REM Uprava pro GW-BASIC
7 REM *****************************
8 REM
9 REM
10 PRINT "X=";
20 INPUT X
30 PRINT "Y=";
40 INPUT Y
50 WHILE X<>Y
60   IF X>Y THEN X=X-Y
70   IF X<Y THEN Y=Y-X
80 WEND 
90 PRINT "GCD: ";X
91 END 
