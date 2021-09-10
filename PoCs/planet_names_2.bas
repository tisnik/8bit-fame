1 REM *****************************
2 REM Planete names generator
3 REM similar to Elite games.
4 REM (tricky solution!)
5 REM *****************************
6 REM 
7 REM
8 REM
9 DIM X$(65)
10 X$="...LEXEGEZACEBISOUSESARMAINDIREA'ERATENBERALAVETIEDORQUANTEISRION"
11 FOR I=1 TO 3+INT(0.4+RND)
12   X=1+PEEK(53770) MOD 32
13   IF X$(X*2,X*2+1)<>".." THEN PRINT X$(X*2,X*2+1);
19 NEXT I
20 PRINT 
99 STOP 
