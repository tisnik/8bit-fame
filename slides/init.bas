10000 REM 
10001 REM ---------------------
10002 REM INICIALIZACE
10003 REM ---------------------
10010 SLIDE=0
10020 MAINLOOP=10
10030 KEYCODE=10100
10031 LEFTKEY=134
10032 RIGHTKEY=135
10090 RETURN 
10100 REM 
10101 REM ---------------------
10102 REM PRECTENI KLAVESY
10103 REM ---------------------
10110 POKE 754,255
10120 IF PEEK(754)=255 THEN 10120
10130 RETURN 