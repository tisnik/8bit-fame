10 REM ****************************
11 REM * Player-missile graphics  *
12 REM * example #7               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - set player 0 color     *
18 REM *                          *
19 REM * - set player 0 shape     *
20 REM *   in form of PMG bitmap  *
21 REM *                          *
22 REM * - turn on PMG DMA        *
23 REM *   for players and also   *
24 REM *   missiles               *
25 REM ****************************
26 REM 
100 REM *** control registers ***
101 REM *** mapped into memory ***
110 REM 
111 REM horizontal position
112 REM of player 0
113 HPOSP0=53248
120 REM 
121 REM color of player 0
122 REM and missille 0
123 PCOLR0=704
130 REM 
131 REM Direct Memory Access (DMA)
132 REM enable flags
133 SDMCTL=559
140 REM 
141 REM Page address of PMG bitmaps
142 REM for players and missiles
143 PMBASE=54279
150 REM 
151 REM turn on/off players
152 REM and missiles
153 GRACTL=53277
160 REM 
161 REM Last page available for
162 REM BASIC programs
163 RAMTOP=106
200 REM 
201 REM *** initialize text mode ***
202 GRAPHICS 0
300 REM 
301 REM *** setup PMG ***
302 REM *** and display player 0 ***
310 POKE HPOSP0,128:REM horizontal position
320 POKE PCOLR0,88:REM color
400 REM 
401 REM *** allocate memory for PMG ***
402 A=PEEK(RAMTOP)-8
403 POKE PMBASE,A
404 PMG_ADDR=256*A
405 POKE SDMCTL,46:REM enable PMG DMA
406 POKE GRACTL,3:REM enable players and missiles
500 REM 
501 REM *** define PMG shape ***
502 REM clear it first
503 FOR I=PMG_ADDR+512 TO PMG_ADDR+640
504 POKE I,0
505 NEXT I
506 REM 8x8 pixels shape
507 Y=64
508 FOR I=PMG_ADDR+512+Y TO PMG_ADDR+512+Y+7
509 READ A
510 POKE I,A
511 NEXT I
512 DATA 24,60,126,219,255,36,90,165
998 REM finito
999 STOP
