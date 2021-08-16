1 REM *****************************
2 REM Vypocet nejvetsiho spolecneho
3 REM delitele.
4 REM 
5 REM Uprava pro BASIC XE
6 REM 
7 REM *****************************
8 REM
9 REM
10 PRINT "X=";
20 INPUT X
30 PRINT "Y=";
40 INPUT Y
50 IF X=Y THEN PRINT "GCD: ";X:END 
60 IF X>Y THEN X=X-Y:GOTO 50
70 IF X<Y THEN Y=Y-X:GOTO 50
999 END
