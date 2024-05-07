rem *****************************
rem
rem Nastavení barvy a použití
rem příkazu pro kresbu úsečky.
rem 
rem Úprava pro EndBASIC
rem 
rem *****************************



for i=0 to 80
    color i
    gfx_line i * 5, 0, 0, 400-i*5
    gfx_line 640 - i * 5, 0, 639, 400-i*5
next
