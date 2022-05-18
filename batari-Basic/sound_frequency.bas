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

  player0x = 20 + 11
  player0y = 20

  scorecolor = $98

  rem Pocatecni hodnota score
  score = 11

  rem Hlasitost
  AUDV0 = 15

  rem Tvar zvukove vlny
  AUDC0 = 4

  rem Frekvence
  f = 11
  AUDF0 = f

mainloop
    rem Barvy pozadi i hrace
    COLUPF = 14
    COLUP0 = $1E

    if joy0left && f > 0 then f = f - 1
    if joy0right && f < 31 then f = f + 1

    AUDF0 = f
    player0x = 20 + f*4
    score = f + 0

    drawscreen
    goto mainloop
