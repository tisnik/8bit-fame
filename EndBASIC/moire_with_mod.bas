rem *****************************
rem
rem Circle moire
rem v grafickém režimu (16 barev)
rem 
rem Úprava pro EndBASIC (s MOD)
rem 
rem *****************************



for y = 0 to 400
    for x = 0 to 400
        c = int(x*x/20+y*y/20)
        c = c MOD 16
        color c
        gfx_pixel x, y
    next
next
