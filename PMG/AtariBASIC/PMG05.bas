10 REM ****************************
11 REM * Player-missile graphics  *
12 REM * example #5               *
13 REM *                          *
14 REM * - set player 0 horizontal*
15 REM *   position               *
16 REM *                          *
17 REM * - dtto for player 1      *
18 REM *                          *
19 REM * - set player 0 color     *
20 REM *                          *
21 REM * - dtto for player 1      *
22 REM *                          *
23 REM * - set player 0 shape     *
24 REM *   across all scanlines   *
25 REM *                          *
26 REM * - dtto for player 1      *
27 REM *                          *
28 REM * - turn off PMG DMA       *
29 REM *   for players and also   *
30 REM *   missiles               *
31 REM ****************************
32 REM 
100 REM *** control registers ***
101 REM *** mapped into memory ***
110 REM 
111 REM horizontal position
112 REM of player 0
113 HPOSP0=53248
114 REM 
115 REM horizontal position
116 REM of player 1
117 HPOSP1=53249
120 REM 
121 REM color of player 0
122 REM and missille 0
123 PCOLR0=704
124 REM 
125 REM color of player 1
126 REM and missile 1
127 PCOLR1=705
130 REM 
140 REM graphics shape for player 0
141 REM (bypass ANTIC)
142 GRAFP0=53261
144 REM 
145 REM graphics shape for player 1
146 REM (bypass ANTIC again)
147 GRAFP1=53262
150 REM 
151 REM turn on/off players
152 REM and missiles
153 GRACTL=53277
200 REM 
201 REM *** initialize text mode ***
202 GRAPHICS 0
300 REM 
301 REM *** setup PMG ***
302 REM *** and display player 0 ***
310 POKE HPOSP0,128:REM horizontal position
311 POKE HPOSP1,160:REM horizontal position
320 POKE PCOLR0,88:REM color for player 0
321 POKE PCOLR1,42:REM color for player 1
340 POKE GRAFP0,255:REM graphics shape
341 POKE GRAFP1,128+32+8+2:REM graphics shape
350 POKE GRACTL,0:REM turn off DMA
998 REM finito
999 STOP
