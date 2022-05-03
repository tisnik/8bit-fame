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
  missile0y = 20
  missile0height = 8

  missile1x = 80+20
  missile1y = 20
  missile1height = 8


mainloop
    NUSIZ0 = $30
    NUSIZ1 = $30
    COLUPF = 14
    COLUP0 = $1E
    COLUP1 = $4E

    drawscreen
    goto mainloop
