10 ------------------------------
11 REM * Player-missile graphics  *
12 REM * example #6               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - set player 0 color     *
18 REM *                          *
19 REM * - turn on PMG DMA        *
20 REM *                          *
21 REM * - set player 0 pattern   *
22 ------------------------------
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
1024   REM 
1025   REM color of player 0
1026   REM and missille 0
1027   PCOLR0=704
1030   REM 
1031   REM turn on/off players
1032   REM and missiles
1033   GRACTL=53277
1040   REM
1041   REM memory page for sprite(s)
1042   PMBASE=54279
1050   REM
1051   REM top memory page for BASIC
1052   RAMTOP=106
1060   REM
1061   REM shadow of DMACTL register
1062   SDMCTL=559
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
3020   POKE PCOLR0,88
3030   Y=48
3035   REM *** memory allocation ***
3040   A=PEEK(RAMTOP)-8
3050   POKE PMBASE,A:REM memory page for sprite(s)
3060   MYPMBASE=256*A
3070   POKE SDMCTL,46:REM setup DMA
3080   POKE GRACTL,3:REM turn on DMA
3090   POKE HPOSP0,128:REM horizontal position
3099   REM *** clear memory for sprite ***
3100   FOR I=MYPMBASE+512 TO MYPMBASE+640
3110     POKE I,0
3120   NEXT I
3129   REM *** set sprite pattern ***
3130   FOR I=MYPMBASE+512+Y TO MYPMBASE+512+Y+7
3140     READ A
3150     POKE I,A
3160   NEXT I
3170   REM *** sprite pattern definition ***
3180   DATA 24,60,126,219,255,36,90,165
3999 ENDPROC 
