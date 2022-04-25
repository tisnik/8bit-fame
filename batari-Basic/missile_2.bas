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


  missile0x = 64
  missile0y = 64
  missile0height = 8

mainloop
    NUSIZ0 = $30
    COLUPF = 14
    COLUP0 = $1E

    if joy0up then missile0y = missile0y - 1
    if joy0down then missile0y = missile0y + 1
    if joy0left then missile0x = missile0x - 1
    if joy0right then missile0x = missile0x + 1

    drawscreen
    goto mainloop
