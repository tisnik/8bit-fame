; asmsyntax=nasm

        ;***************************************************************
        ;*   Projekt cislo 2 do predmetu Strojove orientovane jazyky   *
        ;*   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   *
        ;* Jmeno: Pavel Tisnovsky                                      *
        ;* Login: xtisno00                                             *
        ;* Kruh:  IVT 27                                               *
        ;***************************************************************

        ;Popis programu
        ; Program vykresluje na obrazovku Juliovu a Mandelbrotovu
        ; mnozinu. Jedna se o fraktaly v komplexni rovine. Program dale
        ; umozni interaktivne menit prubeh zobrazovani:
        ; -pocet iteraci, barevnou paletu, pocatecni podminky...
        ;
        ;Popis algoritmu:
        ; Program je zalozen na algoritmu nasobeni cisel v komplexni
        ; rovine.
        ; Algoritmus pro vypocet Mandelbrotovy a Juliovy mnoziny:
        ; repeat
        ;   z(n+1)=z(n)^2+c
        ;   iterace++
        ; until |z(n+1)|>2 or iterace>max_iter
        ; (pro kazdy bod v komplexni rovine).
        ;
        ; z(n) a z(n+1) jsou cisla v komplexni rovine
        ; c je komplexni konstanta
        ; iterace je pocet iteraci (zadano uzivatelem)
        ;
        ; Rozdil mezi Mandelbrotovou a Juliovou mnozinou:
        ; Mandelbrotova mnozina nastavuje c na hodnotu z(0)
        ; a z(0) nastavi dle pocatecni podminky.
        ; Juliova mnozina nastavuje c dle pocatecni podminky.
        ;
        ;Aritmeticke operace jsou provedeny v 32-bitovem x-pointu, tzn.
        ;jde o cisla v pevne radove carce, kde prvnich 16 bitu je cela
        ;cast a druhych 16 bitu je cast za dvojkovou teckou.
        ;Scitani a odcitani-jako u celych cisel
        ;Nasobeni a deleni -je nutne provest posun pro zarovnani
        ;vysledku (32 bitu*32 bitu->32 bitu).
        ;Z tohoto duvodu jsou vyuzivany instrukce procesoru 386 pro
        ;pocitani s registry o delce 32 bitu.
        ;
        ;Hardwarove naroky:
        ; CPU min.386, odzkouseno na 486DX2
        ; VGA karta 256kB
        ; std.klavesnice
        ;
        ;Softwarove naroky:
        ; DOS 3.3 a vyse (odzkouseno i pod W95 v okne)
        ;
        ;Podminky pro preklad:
        ; Jde prelozit TASM 2.51 a TASM 3.2
        ; TASM 3.1 preklada chybne (asi chyba kompilatoru???)
        ; viz nasledujici tabulka:
        ;
        ; compiler   linker     vel.obj  vel.com  status
        ; TASM 2.51  TLINK 4.01  3032     2293     OK
        ; TASM 3.1   TLINK 5.1   3020     2281     Error
        ; TASM 3.2   TLINK 5.1   3032     2293     OK   (identicky s TASM 2.51)
        ;

bits 16

LF      equ     0ah             ;znak pro posun stranky
CR      equ     0dh             ;znak pro navrat voziku

; *** ascii a scan kody klaves pro int 16h (cteni klavesnice) ***
ESCAPE  equ     1bh             ;<ESC>
KEY_1   equ     31h             ;<1>
KEY_2   equ     32h             ;<2>
KEY_3   equ     33h             ;<3>
PLUS    equ     3dh             ;<+>
MINUS   equ     2dh             ;<->
DOLEVA  equ     4bh             ;<>
DOPRAVA equ     4dh             ;<>
NAHORU  equ     48h             ;<>
DOLU    equ     50h             ;<>
CARKA   equ     2ch             ;<,>
TECKA   equ     2eh             ;<.>
L_ZAV   equ     5bh             ;<[>
P_ZAV   equ     5dh             ;<]>
KEY_R   equ     52h             ;<R>
KEY_R_  equ     72h             ;<r>

P       equ     65536           ;poloha desetinne tecky v X-pointu
K       equ     4*P/128         ;vzdalenost mezi dvema body (krok smycky)
MIN     equ     -2*P            ;minimalni a maximalni hodnota konstant fraktalu
                                ;v komplexni rovine



;-----------------------------------------------------------------------------
section .data

nadpis  db LF,LF,LF,CR
        db " ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»",CR,LF
        db " º         REAL-TIME FRAKTALY         º",CR,LF
        db " ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶",CR,LF
        db " º Autor: Pavel Tisnovsky (xtisno00)  º",CR,LF
        db " ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶",CR,LF
        db " º         VUT-FEI BRNO 1996          º",CR,LF
        db " ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼",0

vyber   db LF,LF,LF,CR
        db " ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿",CR,LF
        db " ³ Vyberte typ fraktalu:              ³",CR,LF
        db " ³                                    ³",CR,LF
        db " ³ 1) Juliova mnozina                 ³",CR,LF
        db " ³ 2) Mandelbrotova mnozina           ³",CR,LF
        db " ³ ESC-konec                          ³",CR,LF
        db " ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ",0

vkonec  db LF,LF,LF,CR
        db " OK-program je ukoncen",CR,LF
        db " Navratovy kod=0",CR,LF,CR,LF,0

mmtext1 db "   ***** MANDELBROTOVA MNOZINA *****",CR,LF,LF,0
mmtext2 db "FUNKCE KLAVES       KOMPLEXNI ROVINA",CR,LF,0

mmtext3 db "<>   zmensit imag.",CR,LF
        db "      cast konstanty",CR,LF
        db "<>   zvetsit imag.",CR,LF
        db "      cast konstanty",CR,LF
        db "<>   zmensit real.",CR,LF
        db "      cast konstanty",CR,LF
        db "<>   zvetsit real.",CR,LF
        db "      cast konstanty",CR,LF
        db "<R>   reset hodnot",CR,LF
        db "<[>   snizit krok",CR,LF
        db "<]>   zvysit krok",CR,LF
        db "<+>   zvysit pocet",CR,LF
        db "      iteraci",CR,LF
        db "<->   snizit pocet",CR,LF
        db "      iteraci",CR,LF
        db "<,>   posun palety",CR,LF
        db "      smerem nahoru",CR,LF
        db "<.>   posun palety",CR,LF
        db "      smerem dolu",CR,LF
        db "<ESC> konec",CR,LF
        db "Pozor na preplneni bufferu klavesnice!",0

jj1     db "      ***** JULIOVA MNOZINA *****",CR,LF,LF,0

cx_     dd 19660                ;realna cast konstanty pro Juliovu mnozinu
cy_     dd 39321                ;imaginarni cast konstanty pro Juliovu mnozinu
pcx     dd 4000                 ;posun realne a imaginarni casti konstanty
iteraci db 32                   ;pocet iteraci
paleta  db 32                   ;posun palety
zx0     dd 0                    ;
zy0     dd 0                    ;pocatecni podminka pro Mandelbrotovu mnozinu

x       dw 0                    ;
y       dw 0                    ;pozice ve fraktalu
zx1     dd 0                    ;
zy1     dd 0                    ;poloha v komplexni rovine rovine
zx2     dd 0                    ;
zy2     dd 0                    ;aktualni poloha v komplexni rovine
zx3     dd 0                    ;zx3=zx2^2 (aby se to nemuselo pocitat 2x)
zy3     dd 0                    ;zy3=zy2^2



;-----------------------------------------------------------------------------
org     0x100
section .text


start:
lstart:                         ;pro navrat z podprogramu
        xor     AH,AH           ;sluzba BIOSu-nastaveni gr.modu
        mov     AL,13h
        int     10h
        lea     AX,[nadpis]     ;
        mov     BL,10           ; >tisk nadpisu
        call    writestr        ;/
        lea     AX,[vyber]      ;
        mov     BL,7            ; >tisk vyberu
        call    writestr        ;/
hl_menu:
        call    clear_key_buffer;vymazat buffer
        xor     AH,AH           ;vystup v AX:scan_kod*256+ascii_kod
        int     16h             ;obsluha klavesnice pres BIOS
        cmp     AL,ESCAPE       ;<ESC>
        je      short ukoncit   ;je-li stlacena klavesa ESC (konec)
        cmp     AL,KEY_1        ;<1>
        je      julia           ;je-li stlacena klavesa 1 (julia)
        cmp     AL,KEY_2        ;<2>
        je      short mandel    ;je-li stlacena klavesa 2 (mandelbrot)
        jmp     short hl_menu   ;jina klavesa ->hlavni menu
ukoncit:
        xor     AH,AH           ;sluzba BIOSu-nastaveni gr.modu
        mov     AL,3
        int     10h
        lea     AX,[vkonec]     ;
        mov     BL,7            ; >vytisknout posledni text
        call    writestr        ;/
        mov     AX,4c00h        ;navratovy kod=0
        int     21h             ;volat sluzbu DOSu 4ch (EXIT)

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: MANDELBROTOVA MNOZINA                                                    ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

mandel: call    g_clear_graph
        xor     BH,BH           ;
        xor     DX,DX           ;
        mov     AH,02           ; /`sluzba BIOSu-nastaveni pozice kurzoru
        int     10h             ;/
        mov     BL,13           ;
        lea     AX,[mmtext1]    ;>tisk nadpisu
        call    writestr        ;/
        mov     BL,12           ;
        lea     AX,[mmtext2]    ; >tisk popisu
        call    writestr        ;/
        xor     BH,BH           ;stranka
        mov     DH,4            ;radek
        xor     DL,DL           ;sloupec  >nastaveni pozice kurzoru
        mov     AH,02           ;        /
        int     10h             ;       /
        mov     BL,9            ;
        lea     AX,[mmtext3]    ; >tisk napovedy
        call    writestr        ;/
mvykr:                          ;*** zacatek vykreslovani ***
        mov     AX,0a000h       ;
        mov     ES,AX           ;/`do ES zacatek obrazove pameti VGA
        mov     DI,320*30+160   ;zacatek vykreslovani na obrazovce
mpp:
        mov     dword [zx1],MIN ;od -2 (realna osa)
        mov     BP,128          ;BP==[x] fraktal bude velikosti 128x128
mforx:  mov     dword [zy1],MIN ;od -2 (imaginarni osa)
        mov     SI,128          ;SI==[y]
mfory:  mov     CL,[iteraci]    ;pocet iteraci
        mov     EAX,[zx0]       ;
        mov     [zx2],EAX       ;/`nastaveni real.casti zacatku
        mov     EAX,[zy0]       ;
        mov     [zy2],EAX       ;/`nastaveni imag.casti zacatku
mrep_:                          ;*** iteracni smycka ***
        mov     EAX,[zx2]       ;
        sar     EAX,8           ;
        imul    EAX             ; /`ZX3:=ZX2^2 (v X-pointu)
        mov     [zx3],EAX       ;/
        mov     EAX,[zy2]       ;
        sar     EAX,8           ;
        imul    EAX             ; /`ZY3:=ZY2^2 (v X-pointu)
        mov     [zy3],EAX       ;/

        mov     EAX,[zx2]       ;
        sar     EAX,8           ;/`ZX2 div 256 (pro mul v X-pointu)
        mov     EBX,[zy2]       ;
        sar     EBX,7           ;/`ZY2 div 256 * 2 (pro mul v X-pointu)
        imul    EBX             ;ZY2:=2*ZX2*ZY2
        add     EAX,[zy1]       ;ZY2:=2*ZX2*ZY2+CY (u Mandelbrota poc.iter.)
        mov     [zy2],EAX       ;ulozit

        mov     EAX,[zx3]       ;
        sub     EAX,[zy3]       ;/`ZX3:=ZX3-ZY3=ZX2^2-ZY2^2
        add     EAX,[zx1]       ;
        mov     [zx2],EAX       ;/`ZX2:=ZX2^2-ZY2^2+CX (u Mandelbrota poc.iter.)
        sub     CL,1            ;pocitadlo iteraci
        jz      short mpokrac   ;konec iteraci ?
        mov     EAX,[zx3]       ;
        add     EAX,[zy3]       ;/`==ZX2^2+ZY2^2
        cmp     EAX,4*P         ;kontrola na bailout (abs[Z]<4)
        jc      short mrep_     ;abs[Z]<4 =>dalsi iterace
mpokrac:
        mov     AL,CL           ;pocet iteraci
        shl     AL,1            ;*2
        add     AL,[paleta]     ;posun na vhodne barvy v palete
        stosb                   ;vykreslit bod+posun na dalsi
        add     dword [zy1],K   ;ZY1:=ZY1+K
        sub     SI,1            ;Y:=Y-1
        jnz     mfory           ;Y!=0 ->dalsi radek
        add     DI,320-128      ;dalsi radek na obrazovce
        add     dword [zx1],K   ;ZX1:=ZX1+K
        sub     BP,1            ;X:=X-1
        jnz     mforx           ;X!=0 ->dalsi radek
mcekkey:                        ;*** cekani na vhodne klavesy ***
        xor     AH,AH           ;vystup v AX:scan_kod*256+ascii_kod
        int     16h             ;obsluha klavesnice pres BIOS
        cmp     AL,ESCAPE       ;je stlaceno ESC?
        je      mkonec
        cmp     AH,DOLEVA
        jne     short mpok00    ;neni-li stlacena klavesa doleva
        mov     EAX,[zx0]       ;
        sub     EAX,[pcx]       ; >zx0+=pcx (posun realne casti poc.iter.)
        mov     [zx0],EAX       ;/
        jmp     mvykr           ;vykreslit
mpok00: cmp     AH,DOPRAVA
        jne     short mpok01    ;neni-li stlacena klavesa doprava
        mov     EAX,[zx0]       ;
        add     EAX,[pcx]       ; >zx0-=pcx (posun realne casti poc.iter.)
        mov     [zx0],EAX       ;/
        jmp     mvykr           ;vykreslit
mpok01: cmp     AH,NAHORU
        jne     short mpok02    ;neni-li stlacena klavesa nahoru
        mov     EAX,[zy0]       ;
        sub     EAX,[pcx]       ; >zy0-=pcy (posun imaginarni casti poc.iter.)
        mov     [zy0],EAX       ;/
        jmp     mvykr           ;vykreslit
mpok02: cmp     AH,DOLU
        jne     short mpok03    ;neni-li stlacena klavesa dolu
        mov     EAX,[zy0]       ;
        add     EAX,[pcx]       ; >zy0+=pcy (posun imaginarni casti poc.iter.)
        mov     [zy0],EAX       ;/
        jmp     mvykr           ;vykreslit
mpok03: cmp     AL,L_ZAV
        jne     short mpok04    ;neni-li stlacena klavesa <[>
        sub     dword [pcx],200 ;zmena kroku
        jmp     mcekkey         ;dalsi klavesa
mpok04: cmp     AL,P_ZAV
        jne     short mpok05    ;neni-li stlacena klavesa <]>
        add     dword [pcx],200 ;zmena kroku
        jmp     mcekkey         ;dalsi klavesa
mpok05: cmp     AL,PLUS
        jne     short mpok06    ;neni-li stlacena klavesa <+>
        add     byte [iteraci],2;zvetseni poctu iteraci
        jmp     mvykr
mpok06: cmp     AL,MINUS
        jne     short mpok07    ;neni-li stlacena klavesa <->
        sub     byte [iteraci],2;zmenseni poctu iteraci
        jmp     mvykr
mpok07: cmp     AL,CARKA
        jne     short mpok08    ;neni-li stlacena klavesa <,>
        dec     byte [paleta];snizit paletu
        jmp     mvykr
mpok08: cmp     AL,TECKA
        jne     short mpok09    ;neni-li stlacena klavesa <.>
        inc     byte [paleta];zvysit paletu
        jmp     mvykr
mpok09: cmp     AL,KEY_R
        jne     short mpok10    ;neni-li stlacena klavesa <R>
        jmp     short mreset
mpok10: cmp     AL,KEY_R_       ;neni-li stlacena klavesa <r>
        jne     short mpok11
        jmp     short mreset
mpok11:
        jmp     mcekkey         ;cekani na dalsi klavesu
mkonec: jmp     lstart

mreset: mov     dword [zx0],0
        mov     dword [zy0],0
        mov     dword [pcx],4000
        mov     byte [iteraci],32
        mov     byte [paleta],32
        jmp     mvykr           ;vykresleni s novymi hodnotami

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: JULIOVA MNOZINA                                                          ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

julia:  call    g_clear_graph
        xor     BH,BH           ;
        xor     DX,DX           ;
        mov     AH,02           ; /`sluzba BIOSu-nastaveni pozice kurzoru
        int     10h             ;/
        mov     BL,13           ;
        lea     AX,[jj1]        ; >tisk nadpisu
        call    writestr        ;/
        mov     BL,12           ;
        lea     AX,[mmtext2]    ; >tisk popisu
        call    writestr        ;/
        xor     BH,BH           ;
        mov     DH,4            ;
        xor     DL,DL           ;  >nastaveni pozice kurzoru
        mov     AH,02           ; /
        int     10h             ;/
        mov     BL,9            ;
        lea     AX,[mmtext3]    ; >tisk napovedy
        call    writestr        ;/
jvykr:                          ;*** zacatek vykreslovani ***
        mov     AX,0a000h
        mov     ES,AX           ;do ES zacatek obrazove pameti
        mov     DI,320*30+160   ;zacatek vykreslovani na obrazovku VGA
        mov     BP,320*30+320*127+127+160;konec vykreslovani (pro opacne vykresl
jpp:
        mov     dword [zx1],MIN ;od -2 (realna osa)
        mov     word [x],64     ;fraktal bude velikosti 128x128 (dve pulky)
jforx:  mov     dword [zy1],MIN ;od -2 (imaginarni osa)
        mov     SI,128          ;SI==[y]
jfory:  mov     CL,[iteraci]    ;pocet iteraci
        mov     EAX,[zx1]       ;
        mov     [zx2],EAX       ;/`ZX2:=ZX1
        mov     EAX,[zy1]       ;
        mov     [zy2],EAX       ;/`ZY2:=ZY1
jrep_:                          ;*** zacatek iteracni smycky
        mov     EAX,[zx2]       ;
        sar     EAX,8           ;
        imul    EAX             ; /`ZX3:=ZX2^2 (v X-pointu)
        mov     [zx3],EAX       ;/
        mov     EAX,[zy2]       ;
        sar     EAX,8           ;
        imul    EAX             ; /`ZY3:=ZY2^2 (v X-pointu)
        mov     [zy3],EAX       ;/

        mov     EAX,[zx2]       ;
        sar     EAX,8           ;/`ZX2 div 256 (pro mul v X-pointu)
        mov     EBX,[zy2]       ;
        sar     EBX,7           ;/`ZY2 div 256 * 2 (pro mul v X-pointu)
        imul    EBX             ;ZY2:=2*ZX2*ZY2
        add     EAX,[cy_]       ;ZY2:=2*ZX2*ZY2+CY_
        mov     [zy2],EAX       ;ulozit

        mov     EAX,[zx3]       ;
        sub     EAX,[zy3]       ;/`ZX3:=ZX3-ZY3=ZX2^2-ZY2^2
        add     EAX,[cx_]       ;
        mov     [zx2],EAX       ;/`ZX2:=ZX2^2-ZY2^2+CX_
        sub     CL,1            ;pocitadlo iteraci
        jz      short jpokrac   ;konec iteraci ?
        mov     EAX,[zx3]       ;
        add     EAX,[zy3]       ;/`==ZX2^2+ZY2^2
        cmp     EAX,4*P         ;kontrola bailout (abs[Z]<4)
        jc      short jrep_
jpokrac:
        mov     AL,CL           ;pocet iteraci
        shl     AL,1            ;*2
        add     AL,[paleta]     ;posun na vhodne barvy v palete
        stosb                   ;vykreslit bod (horni pulka)
        mov     [ES:BP],AL      ;vykreslit bod (dolni pulka)
        dec     BP              ;dalsi bod
        add     dword [zy1],K   ;ZY1:=ZY1+K
        sub     SI,1            ;Y:=Y-1
        jnz     jfory           ;Y!=0 ->dalsi radek
        add     DI,320-128      ;dalsi radek na obrazovce (horni pulka)
        sub     BP,320-128      ;predchozi radek na obrazovce (dolni pulka)
        add     dword [zx1],K   ;ZX1:=ZX1+K
        sub     word [x],1      ;X:=X-1
        jnz     jforx           ;X!=0 ->dalsi radek
jcekkey:                        ;*** cekani na vhodne klavesy ***
        xor     AH,AH           ;vystup v AX:scan_kod*256+ascii_kod
        int     16h             ;obsluha klavesnice pres BIOS
        cmp     AL,ESCAPE       ;je stlaceno ESC?
        je      jkonec
        cmp     AH,DOLEVA
        jne     short jpok00    ;neni-li stlacena klavesa doleva
        mov     EAX,[cx_]       ;
        sub     EAX,[pcx]       ; >cx_+=pcx (posun realne casti konstanty)
        mov     [cx_],EAX       ;/
        jmp     jvykr           ;vykreslit
jpok00: cmp     AH,DOPRAVA
        jne     short jpok01    ;neni-li stlacena klavesa doprava
        mov     EAX,[cx_]       ;
        add     EAX,[pcx]       ; >cx_-=pcx (posun realne casti konstanty)
        mov     [cx_],EAX       ;/
        jmp     jvykr           ;vykreslit
jpok01: cmp     AH,NAHORU
        jne     short jpok02    ;neni-li stlacena klavesa nahoru
        mov     EAX,[cy_]       ;
        sub     EAX,[pcx]       ; >cy_-=pcy (posun imaginarni casti konstanty)
        mov     [cy_],EAX       ;/
        jmp     jvykr           ;vykreslit
jpok02: cmp     AH,DOLU
        jne     short jpok03    ;neni-li stlacena klavesa dolu
        mov     EAX,[cy_]       ;
        add     EAX,[pcx]       ; >cy_+=pcy (posun imaginarni casti konstanty)
        mov     [cy_],EAX       ;/
        jmp     jvykr           ;vykreslit
jpok03: cmp     AL,L_ZAV
        jne     short jpok04    ;neni-li stlacena klavesa <[>
        sub     dword [pcx],200 ;zmena kroku
        jmp     jcekkey         ;dalsi klavesa
jpok04: cmp     AL,P_ZAV
        jne     short jpok05    ;neni-li stlacena klavesa <]>
        add     dword [pcx],200 ;zmena kroku
        jmp     jcekkey         ;dalsi klavesa
jpok05: cmp     AL,PLUS
        jne     short jpok06    ;neni-li stlacena klavesa <+>
        add     byte [iteraci],2;zvetseni poctu iteraci
        jmp     jvykr
jpok06: cmp     AL,MINUS
        jne     short jpok07    ;neni-li stlacena klavesa <->
        sub     byte [iteraci],2;zmenseni poctu iteraci
        jmp     jvykr
jpok07: cmp     AL,CARKA
        jne     short jpok08    ;neni-li stlacena klavesa <,>
        dec     byte [paleta]   ;snizit paletu
        jmp     jvykr
jpok08: cmp     AL,TECKA
        jne     short jpok09    ;neni-li stlacena klavesa <.>
        inc     byte [paleta]   ;zvysit paletu
        jmp     jvykr
jpok09: cmp     AL,KEY_R
        jne     short jpok10    ;neni-li stlacena klavesa <R>
        jmp     short jreset
jpok10: cmp     AL,KEY_R_       ;neni-li stlacena klavesa <r>
        jne     short jpok11
        jmp     short jreset
jpok11:
        jmp     jcekkey         ;cekani na dalsi klavesu
jkonec: jmp     lstart

jreset: mov     dword [cx_],19660
        mov     dword [cy_],39321
        mov     dword [pcx],4000
        mov     byte [iteraci],32
        mov     byte [paleta],32
        jmp     jvykr

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: Procedura pro tisk retezce na obrazovku (AX-adresa retezce, BL-barva )   ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

writestr:
        pusha                   ;uschovat registry
        mov     SI,AX           ;v DS:SI je adresa retezce
        mov     AH,0eh          ;sluzba BIOSu-emulace TTY
opak00: lodsb                   ;nacteni AL z DS:SI
        cmp     AL,0            ;test na konec retezce
        jz      short konec00   ;je-li konec retezce
        int     10h             ;tisknout znak
        jmp     short opak00    ;dalsi znak
konec00:popa                    ;obnovit registry
        ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: Procedura pro vymazani bufferu klavesnice                                ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

clear_key_buffer:               ;vymaze buffer klavesnice
opak01: mov     AH,1            ;sluzba BIOSu-cteni stavu bufferu klavesnice
        int     16h
        jz      short konec01   ;zadna klavesa v bufferu->konec
        xor     AH,AH           ;sluzba BIOSu-cteni klavesy z bufferu
        int     16h
        jmp     short opak01    ;dalsi klavesa
konec01:ret

;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;: Procedura pro smazani obrazovky v modu 320x200x256                       ::
;:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

g_clear_graph:
        pusha
        mov     AX,0A000h
        mov     ES,AX
        xor     DI,DI           ;zacatek na A000:0000
        xor     AX,AX           ;co se bude zapisovat
        mov     CX,32000        ;32000*2=64000
        rep     stosw           ;zapis
        popa
        ret

