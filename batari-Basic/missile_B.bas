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


  missile0x = 80-2
  missile0y = 28-2
  missile0height = 8

  missile1x = 80+2
  missile1y = 28+2
  missile1height = 8


mainloop
    CTRLPF = $05

    NUSIZ0 = $30
    NUSIZ1 = $30
    COLUPF = 14
    COLUP0 = $1E
    COLUP1 = $4E

    drawscreen
    goto mainloop
