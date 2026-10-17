10 ------------------------------
11 REM nastaveni spritu
12 ------------------------------
20 PMBASE=54279
21 RAMTOP=106
22 SDMCTL=559
23 GRACTL=53277
24 HPOSP0=53248
25 PCOLR0=704
30 EXEC INIT_PGM
40 EXEC ERASE_P0
50 EXEC INIT_P0_BITMAP
60 ------------------------------
61 REM vymazani casovace
62 ------------------------------
70 POKE 18,0
71 POKE 19,0
72 POKE 20,0
80 ------------------------------
81 REM vlastni benchmark
82 ------------------------------
100 FOR Y=0 TO 255
101   MOVE MYPMBASE+256, MYPMBASE+Y, 18
102 NEXT Y
200 REM precteni casovace
201 REM (platne pro pal)
202 T=((PEEK(18)*65536+PEEK(19)*256+PEEK(20))/50)
203 PRINT "FINISHED IN ";T;" SECONDS"
999 END 
1000 ------------------------------
1001 REM 
1002 REM vymazani oblasti prvniho hrace
1003 REM 
1004 PROC ERASE_P0
1005   FOR I=MYPMBASE TO MYPMBASE+256
1006     POKE I,0
1007   NEXT I
1008 ENDPROC 
1100 ------------------------------
1101 REM 
1102 REM inicializace bitmapy prvniho hrace
1103 REM 
1104 PROC INIT_P0_BITMAP
1105   FOR I=MYPMBASE+256 TO MYPMBASE+256+17
1106     READ A
1107     POKE I,A
1108   NEXT I
1109   DATA 0,24,24,60,60,126,126,219,219,255,255,36,36,90,90,165,165,0
1110 ENDPROC 
1200 ------------------------------
1201 REM 
1202 REM inicializace PMG
1203 REM 
1204 PROC INIT_PGM
1205   POKE PCOLR0,31
1206   REM stranka delitelna ctyrmi
1207   A=120
1208   POKE PMBASE,A
1209   MYPMBASE=256*A+1024
1210   POKE GRACTL,3
1211   POKE HPOSP0,120
1217   POKE SDMCTL,42+16
1220 ENDPROC 
