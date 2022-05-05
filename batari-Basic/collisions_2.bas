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

  player0x = 20
  player0y = 20

  player1x = 140
  player1y = 30

  missile0x = 80
  missile0y = 40
  missile0height = 4

  missile1x = 80
  missile1y = 60
  missile1height = 4

  ballx = 80
  bally = 50
  ballheight = 8

  rem Posun hrace #1 v horizontalnim smeru
  let a = 1

  rem Posun hrace #2 v horizontalnim smeru
  let b = 1

  rem Posun strely 0 v horizontalnim i vertikalnim smeru
  let c = 1
  let d = 1

  rem Posun strely 1 v horizontalnim i vertikalnim smeru
  let e = 1
  let f = -1

mainloop
    rem Sirka strel
    NUSIZ0 = $20
    NUSIZ1 = $20

    rem Sirka mice
    CTRLPF = $31

    rem Barvy pozadi i hracu
    COLUPF = 14
    COLUP0 = $1E
    COLUP1 = $4E

    player0x = player0x + a
    if player0x >= 152 then player0x = 152: a =- 1
    if player0x <= 0 then player0x = 0: a = 1

    player1x = player1x + b
    if player1x >= 152 then player1x = 152: b =- 1
    if player1x <= 1 then player1x = 1: b = 1

    missile0x = missile0x + c
    if missile0x >= 152 then missile0x = 152: c =- 1
    if missile0x <= 1 then missile0x = 1: c = 1
    missile0y = missile0y + d
    if missile0y >= 80 then missile0y = 80: d =- 1
    if missile0y <= 10 then missile0y = 10: d = 1

    missile1x = missile1x + e
    if missile1x >= 152 then missile1x = 152: e =- 1
    if missile1x <= 1 then missile1x = 1: e = 1
    missile1y = missile1y + f
    if missile1y >= 80 then missile1y = 80: f =- 1
    if missile1y <= 10 then missile1y = 10: f = 1

    if joy0up then bally = bally - 1
    if joy0down then bally = bally + 1
    if joy0left then ballx = ballx - 1
    if joy0right then ballx = ballx + 1

    if collision(missile0, player0) then COLUPF = $38
    if collision(missile0, player1) then COLUPF = $48
    if collision(missile1, player0) then COLUPF = $58
    if collision(missile1, player1) then COLUPF = $68
    if collision(missile0, missile1) then COLUPF = $78
    if collision(ball, player0) then COLUP0 = $48
    if collision(ball, player1) then COLUP1 = $48
    if collision(ball, missile0) then COLUP0 = $48
    if collision(ball, missile1) then COLUP1 = $48

    drawscreen
    goto mainloop
