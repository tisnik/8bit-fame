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

  player0x = 80
  player0y = 48

mainloop
    NUSIZ0 = $05
    COLUPF = 14
    COLUP0 = $1E

    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 1
    if joy0left then player0x = player0x - 1
    if joy0right then player0x = player0x + 1

    drawscreen
    goto mainloop
