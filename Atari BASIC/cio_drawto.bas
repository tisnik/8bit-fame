10 REM Kresleni usecky pomoci prikazu XIO
11 REM
20 REM Nastaveni grafickeho rezimu 40x20x4
21 GRAPHICS 3
30 REM Umisteni na obrazovce + kresleni prvniho bodu
31 POSITION 0, 0
32 PUT #6, 1
40 REM Vykresleni usecky
42 POSITION 10, 10
43 XIO 17, #6, 0, 0, "S:"
50 REM Finito
