  playfield:
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ................................
 ................................
 ...XXXX....XXX.....XXX...XXXXX..
 ...X...X..X...X...X...X....X....
 ...XXXX...X...X...X...X....X....
 ...X.X....X...X...X...X....X....
 ...X..X...X...X...X...X....X....
 ...X...X...XXX.....XXX.....X....
 ................................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end


  missile0x = 80-20
  missile0y = 28-2
  missile0height = 8

  missile1x = 80+20
  missile1y = 28+2
  missile1height = 8


mainloop
    NUSIZ0 = $30
    NUSIZ1 = $30
    COLUPF = $7F
    COLUP0 = $1E
    COLUP1 = $4E

    if joy0up then missile0y = missile0y - 1
    if joy0down then missile0y = missile0y + 1
    if joy0left then missile0x = missile0x - 1
    if joy0right then missile0x = missile0x + 1
    if collision(missile0, missile1) then COLUPF = $48

    drawscreen
    goto mainloop
