10 REM ****************************
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
131 REM graphics shape for player 0
132 REM (bypass ANTIC)
133 GRAFP0=53261
140 REM 
141 REM turn on/off players
142 REM and missiles DMA
143 GRACTL=53277
200 REM
201 REM *** initialize text mode ***
202 GRAPHICS 0
300 REM
301 REM *** setup PMG ***
302 REM *** and display player 0 ***
310 POKE HPOSP0,128:REM horizontal position
320 POKE PCOLR0,88:REM color
330 POKE GRAFP0,255:REM graphics shape
340 POKE GRACTL,0:REM turn off DMA
998 REM finito
999 STOP
