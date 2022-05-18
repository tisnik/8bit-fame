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
   %01000010
   %10000001
   %10000001
   %01011010
   %01011010
   %11111111
   %11111111
   %11011011
   %11011011
   %01111110
   %01111110
   %00111100
   %00111100
   %00011000
   %00011000
end

  player0x = 80
  player0y = 48

mainloop
    COLUPF = 14
    COLUP0 = $1E

    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 1
    if joy0left then player0x = player0x - 1
    if joy0right then player0x = player0x + 1
    if joy0fire then a = a + 1

    rem Zpomaleni zmeny
    if a > 8 then b = b + 1: a = 0
    if b = 5 then b = 6
    if b = 7 then b = 0
    NUSIZ0 = b

    drawscreen
    goto mainloop
