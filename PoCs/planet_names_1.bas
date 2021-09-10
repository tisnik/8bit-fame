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
11 X=1+PEEK(53770) MOD 32
12 PRINT X$(X*2,X*2+1);
13 X=1+PEEK(53770) MOD 32
14 PRINT X$(X*2,X*2+1);
15 X=1+PEEK(53770) MOD 32
16 PRINT X$(X*2,X*2+1);
17 X=1+PEEK(53770) MOD 32
18 PRINT X$(X*2,X*2+1)
99 STOP 
