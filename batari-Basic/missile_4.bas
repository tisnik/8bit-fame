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


10 missile0x = 64
20 missile0y = 64
30 missile0height = 8

40 a = $1E

50
51  NUSIZ0 = $30
52  COLUPF = $7F
53  COLUP0 = a

54  if joy0up then missile0y = missile0y - 1
55  if joy0down then missile0y = missile0y + 1
56  if joy0left then missile0x = missile0x - 1
57  if joy0right then missile0x = missile0x + 1
58  if joy0fire then a = a + 1

59  drawscreen
60  goto 50
