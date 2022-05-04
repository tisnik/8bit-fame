  playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 ................................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end

   player0:
   %01000010
   %10000001
   %01011010
   %11111111
   %11011011
   %01111110
   %00111100
   %00011000
end

  player0x = 20
  player0y = 20

  rem Hlasitost
  AUDV0 = 0

  rem Tvar zvukove vlny
  AUDC0 = 4

  rem Frekvence: A4
  AUDF0 = 11

mainloop
    rem Barvy pozadi i hrace
    COLUPF = 14
    COLUP0 = $1E

    if joy0fire then COLUP0 = $48:AUDV0 = 15
    if !joy0fire then AUDV0 = 0
    
    drawscreen
    goto mainloop
