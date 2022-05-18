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
    COLUPF = 14
    COLUP0 = $1E

    drawscreen
    goto mainloop
