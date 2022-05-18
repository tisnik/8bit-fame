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

  ballx = 80
  bally = 50
  ballheight = 8

  rem Posun mice 0 v horizontalnim i vertikalnim smeru
  let c = 1
  let d = 1

mainloop
    rem Sirka mice
    CTRLPF = $31

    rem Barvy pozadi
    COLUPF = 14

    ballx = ballx + c
    if ballx >= 152 then ballx = 152: c =- 1
    if ballx <= 1 then ballx = 1: c = 1
    bally = bally + d
    if bally >= 80 then bally = 80: d =- 1
    if bally <= 10 then bally = 10: d = 1

    drawscreen
    goto mainloop
