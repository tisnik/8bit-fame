1 REM *****************************
2 REM Vypis vsech znaku primo na
3 REM obrazovku v rezimu GRAPHICS 8
4 REM 
5 REM Uprava pro Atari BASIC
6 REM
7 REM *****************************
8 REM
9 REM
10 GRAPHICS 0
20 REM Pocatecni adresa video RAM
25 START=PEEK(88)+256*PEEK(89)
30 REM Tisk sestnacti radku
35 FOR Y=0 TO 15
40 REM Tisk sestnacti sloupcu
45 FOR X=0 TO 15
50 REM Adresa ve video RAM pro zapis
55 ADDR=START+X+Y*40
60 REM Kod znaku pro zapis
65 CODE=X+Y*16
70 REM Vlastni zapis znaku na obrazovku
75 POKE ADDR,CODE
80 NEXT X
85 NEXT Y
90 REM finito
99 GOTO 99
