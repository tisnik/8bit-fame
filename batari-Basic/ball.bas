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
