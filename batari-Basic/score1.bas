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

  scorecolor = $98

  rem Pocatecni hodnota score
  score = 0

mainloop
    if joy0fire then score = score + 1

    drawscreen
    goto mainloop
