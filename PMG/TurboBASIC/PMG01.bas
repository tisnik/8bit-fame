10 ------------------------------
11 REM * Player-missile graphics  *
12 REM * example #1               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - set player 0 shape     *
18 REM *   across all scanlines   *
19 ------------------------------
20 REM 
100 EXEC INIT_PMG_REGISTERS
110 EXEC INIT_TEXT_MODE
120 EXEC DISPLAY_PMG
998 REM finito
999 STOP
1000 ------------------------------
1001 PROC INIT_PMG_REGISTERS
1002   REM *** control registers ***
1003   REM *** mapped into memory ***
1010   REM 
1011   REM horizontal position
1012   REM of player 0
1013   HPOSP0=53248
1020   REM 
1021   REM graphics shape for player 0
1022   REM (bypass ANTIC)
1023   GRAFP0=53261
1099 ENDPROC 
2000 ------------------------------
2001 PROC INIT_TEXT_MODE
2002   REM *** initialize text mode ***
2003   REM 
2010   GRAPHICS 0
2099 ENDPROC 
3000 ------------------------------
3001 PROC DISPLAY_PMG
3002   REM *** setup PMG ***
3003   REM *** and display player 0 ***
3004   REM 
3010   POKE HPOSP0,128:REM horizontal position
3020   POKE GRAFP0,255:REM graphics shape
3099 ENDPROC 
