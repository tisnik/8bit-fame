; Graficky rezim karty Hercules s rozlisenim 720x348 znaku.
;
; preklad pomoci:
;     nasm -f bin -o hercules.com hercules_gfx_mode_2.asm
;
; nebo pouze:
;     nasm -o hercules.com hercules_gfx_mode_2.asm


;-----------------------------------------------------------------------------

; registry karty Hercules
hercules_index    equ 0x3b4
hercules_data     equ 0x3b5
hercules_control  equ 0x3b8
hercules_status   equ 0x3ba
hercules_config   equ 0x3bf

; ridici bity
screen_on equ 0x08
graphics  equ 0x02
text      equ 0x20
enable    equ 0x03



; ukonceni procesu a navrat do DOSu
%macro exit 0
        mov     ah, 0x4c
        int     0x21
%endmacro

; vyprazdneni bufferu klavesnice a cekani na klavesu
%macro wait_key 0
        xor     ax, ax
        int     0x16
%endmacro

; nastaveni konfiguracniho registru
%macro set_config 1
        mov dx, hercules_config
        mov al, %1    ; ridici registr
        out dx, al
%endmacro

; nastaveni ridiciho registru
%macro set_control 1
        mov dx, hercules_control
        mov al, %1    ; ridici registr
        out dx, al
%endmacro

;-----------------------------------------------------------------------------
org  0x100        ; zacatek kodu pro programy typu COM (vzdy se zacina na 256)

start:
        call init_graphics

        mov ax, 0xb000
        mov es, ax
        mov di, 0         ; nyni ES:DI obsahuje adresu prvniho znaku ve video RAM

        mov cx, 90*348    ; pocet zapisovanych bajtu
        xor al, al        ; kod zapisovaneho bajtu
        rep stosb         ; vymazat obrazovku

        xor ax, ax        ; x-ova souradnice
        mov cx, 348       ; pocitadlo vykreslenych pixelu
opak:
        mov  bx, ax       ; y-ova souradnice
        mov  dl, 1        ; barva vykreslovaneho pixelu

        push ax           ; uchovat (tyto registry se v subrutine poskodi)
        push cx           ; uchovat (tyto registry se v subrutine poskodi)
        call putpixel     ; ax=x, bx=y, dl=barva
        pop cx            ; obnovit
        pop ax            ; obnovit

        inc ax            ; x+=1
        loop opak         ; a dalsi pixel

        wait_key
        exit              ; hotovo


init_graphics:
        set_config enable
        set_control graphics

        ; inicializace ridicich registru cipu Motorola 6845
        mov     si, gtable               ; DS:SI obsahuje adresu tabulky s hodnotami registru

        mov     dx, hercules_index       ; registr pro zapis
        mov     cx, 12                   ; pocet nastavovanych parametru
        xor     ah, ah                   ; zaciname registrem cislo 0

parms:  mov     al, ah                   ; zapis cisla registru
        out     dx, al

        inc     dx                       ; adresa portu datoveho registru
        lodsb                            ; precist hodnotu registru z tabulky
        out     dx, al                   ; zapis hodnoty registru na port

        inc     ah                       ; dalsi CRTC registr
        dec     dx                       ; obnoveni cisla portu
        loop    parms                    ; go do another one

        set_control graphics + screen_on ; zapnuti obrazovky
        ret                              ; vse hotovoa


gtable: db      35h,2dh,2eh,07h
        db      5bh,02h,57h,57h
        db      02h,03h,00h,00h


; vykresleni pixelu
; kod prevzaty z Fractintu a upraveny do podoby kompatibilni s NASMem
; provedeny dalsi optimalizace pro Intel 8086
putpixel:
        mov     si, bx           ; y-ova souradnice
        shl     si, 1            ; vypositat offset (v tabulce jsou ulozena slova, ne bajty)
        lea     bx, HGCRegen     ; adresa tabulky
        mov     si, [bx+si]      ; ziskat adresu obrazoveho radku odpovidajiciho y-ove souradnici

        mov     cx, ax           ; uschovat x-ovou souradnici (registr AX se prepise)
        shr     ax, 1
        shr     ax, 1
        shr     ax, 1            ; vydelit osmi -> ziskani offsetu v ramci obrazoveho radku
        
        add     si, ax           ; nyni je v ES:SI adresa zapisovaneho bajtu

        and     cx, 0x07         ; bit v ramci bajtu
        mov     al, 0x80         ; vypocet bitove masky
        shr     al, cl           ; bitova maska je nyni v AL

        mov     cx, 0xb000       ; segment video RAM
        mov     es, cx           ; do registru ES

        cmp     dl, 0            ; ma se vykreslit cerny pixel?
        je      black_pixel      ; pokud ano -> skok

white_pixel:
        or      es:[si], al      ; vykresleni bileho pixelu
        ret                      ; konec
black_pixel:
        xor     al, 0xff         ; inverze masky
        and     es:[si], al      ; vykresleni cerneho pixelu
        ret                      ; konec


                ;offsets into HGC regen buffer for each scan line
HGCRegen        dw      0,8192,16384,24576,90,8282,16474,24666
                dw      180,8372,16564,24756,270,8462,16654,24846
                dw      360,8552,16744,24936,450,8642,16834,25026
                dw      540,8732,16924,25116,630,8822,17014,25206
                dw      720,8912,17104,25296,810,9002,17194,25386
                dw      900,9092,17284,25476,990,9182,17374,25566
                dw      1080,9272,17464,25656,1170,9362,17554,25746
                dw      1260,9452,17644,25836,1350,9542,17734,25926
                dw      1440,9632,17824,26016,1530,9722,17914,26106
                dw      1620,9812,18004,26196,1710,9902,18094,26286
                dw      1800,9992,18184,26376,1890,10082,18274,26466
                dw      1980,10172,18364,26556,2070,10262,18454,26646
                dw      2160,10352,18544,26736,2250,10442,18634,26826
                dw      2340,10532,18724,26916,2430,10622,18814,27006
                dw      2520,10712,18904,27096,2610,10802,18994,27186
                dw      2700,10892,19084,27276,2790,10982,19174,27366
                dw      2880,11072,19264,27456,2970,11162,19354,27546
                dw      3060,11252,19444,27636,3150,11342,19534,27726
                dw      3240,11432,19624,27816,3330,11522,19714,27906
                dw      3420,11612,19804,27996,3510,11702,19894,28086
                dw      3600,11792,19984,28176,3690,11882,20074,28266
                dw      3780,11972,20164,28356,3870,12062,20254,28446
                dw      3960,12152,20344,28536,4050,12242,20434,28626
                dw      4140,12332,20524,28716,4230,12422,20614,28806
                dw      4320,12512,20704,28896,4410,12602,20794,28986
                dw      4500,12692,20884,29076,4590,12782,20974,29166
                dw      4680,12872,21064,29256,4770,12962,21154,29346
                dw      4860,13052,21244,29436,4950,13142,21334,29526
                dw      5040,13232,21424,29616,5130,13322,21514,29706
                dw      5220,13412,21604,29796,5310,13502,21694,29886
                dw      5400,13592,21784,29976,5490,13682,21874,30066
                dw      5580,13772,21964,30156,5670,13862,22054,30246
                dw      5760,13952,22144,30336,5850,14042,22234,30426
                dw      5940,14132,22324,30516,6030,14222,22414,30606
                dw      6120,14312,22504,30696,6210,14402,22594,30786
                dw      6300,14492,22684,30876,6390,14582,22774,30966
                dw      6480,14672,22864,31056,6570,14762,22954,31146
                dw      6660,14852,23044,31236,6750,14942,23134,31326
                dw      6840,15032,23224,31416,6930,15122,23314,31506
                dw      7020,15212,23404,31596,7110,15302,23494,31686
                dw      7200,15392,23584,31776,7290,15482,23674,31866
                dw      7380,15572,23764,31956,7470,15662,23854,32046
                dw      7560,15752,23944,32136,7650,15842,24034,32226
                dw      7740,15932,24124,32316
