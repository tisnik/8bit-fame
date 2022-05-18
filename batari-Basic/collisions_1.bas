  rem Základy Batari BASICu
  rem
  rem Použito v článcích:
  rem
  rem Tvorba her pro Atari 2600 v Batari BASICu: úkol pro hardcode programátory
  rem https://www.root.cz/clanky/tvorba-her-pro-atari-2600-v-batari-basicu-ukol-pro-hardcode-programatory/
  rem
  rem Tvorba her pro Atari 2600 v Batari BASICu: ovládání čipu TIA 
  rem https://www.root.cz/clanky/tvorba-her-pro-atari-2600-v-batari-basicu-ovladani-cipu-tia/
  rem
  rem Tvorba her pro Atari 2600 v Batari BASICu: standardní kernel a zvuky
  rem https://www.root.cz/clanky/tvorba-her-pro-atari-2600-v-batari-basicu-standardni-kernel-a-zvuky/

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
