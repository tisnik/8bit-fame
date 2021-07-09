100 REM *** control registers ***
101 REM *** mapped into memory ***
110 REM 
111 REM horizontal position
112 REM of player 0
113 HPOSP0=53248
120 REM 
121 REM graphics shape for player 0
122 REM (bypass ANTIC)
123 GRAFP0=53261
200 REM
201 REM *** initialize text mode ***
202 GRAPHICS 0
300 REM
301 REM *** setup PMG ***
302 REM *** and display player 0 ***
310 POKE HPOSP0,128:REM horizontal position
330 POKE GRAFP0,255:REM graphics shape
999 END 
