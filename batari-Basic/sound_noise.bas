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

   player1:
   %10100101
   %01011010
   %00100100
   %11111111
   %11011011
   %01111110
   %00111100
   %00011000
end

  rem Hlasitost
  AUDV0 = 15

  rem Tvar zvukove vlny
  s = 0
  AUDC0 = s

  rem Frekvence
  f = 11
  AUDF0 = f

  player0x = 20 + f * 4
  player0y = 20

  player1x = 20 + s * 4
  player1y = 40

  scorecolor = $98

  rem Pocatecni hodnota score
  score = 0 + f

mainloop
    rem Barva pozadi i hracu
    COLUPF = 14
    COLUP1 = $4E

    if joy0left && f > 0 then f = f - 1:score = score - 1
    if joy0right && f < 31 then f = f + 1:score = score + 1

    if joy0up && s > 0 then s = s - 1:score = score - 1000
    if joy0down && s < 15 then s = s + 1:score = score + 1000

    AUDF0 = f
    AUDC0 = s

    player0x = 20 + f*4
    player1x = 20 + s*4
    
    drawscreen
    goto mainloop
