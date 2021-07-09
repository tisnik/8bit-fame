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
131 REM size of player 0
132 SIZEP0=53256
133 REM 
140 REM graphics shape for player 0
141 REM (bypass ANTIC)
142 GRAFP0=53261
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
320 POKE PCOLR0,88:REM color
330 POKE SIZEP0,0:REM horizontal size
340 POKE GRAFP0,255:REM graphics shape
350 POKE GRACTL,0:REM turn off DMA
360 P=1^1^1^1:REM pause
370 POKE SIZEP0,1:REM double size
380 P=1^1^1^1:REM pause
390 POKE SIZEP0,3:REM quadruple size
999 END 
