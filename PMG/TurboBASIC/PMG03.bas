10 ------------------------------
11 REM * Player-missile graphics  *
12 REM * example #3               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - set player 0 color     *
18 REM *                          *
19 REM * - set player 0 shape     *
20 REM *   across all scanlines   *
21 REM *                          *
22 REM * - turn off PMG DMA       *
23 REM *   for players and also   *
24 REM *   missiles               *
25 ------------------------------
26 REM 
100 EXEC INIT_PMG_REGISTERS
110 EXEC INIT_TEXT_MODE
120 EXEC DISPLAY_PMG
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
1021   REM color of player 0
1022   REM and missille 0
1023   PCOLR0=704
1030   REM 
1031   REM graphics shape for player 0
1032   REM (bypass ANTIC)
1033   GRAFP0=53261
1040   REM 
1041   REM turn on/off players
1042   REM and missiles DMA
1043   GRACTL=53277
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
3020   POKE PCOLR0,88:REM color
3030   POKE GRAFP0,255:REM graphics shape
3040   POKE GRACTL,0:REM turn off DMA
3099 ENDPROC 
