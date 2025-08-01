; Example that is used in following article:
;    Vývoj pro ZX Spectrum: dokončení realizace příkazu PLOT
;    https://www.root.cz/clanky/vyvoj-pro-zx-spectrum-dokonceni-realizace-prikazu-plot/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #59:
;    Print ASCII table in normal and also inverse colors on screen.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/59-configurable-ascii-table.asm



SCREEN_ADR      equ $4000
CHAR_ADR        equ $3c00
ENTRY_POINT     equ $8000

NOP_INSTRUCTION equ 0


        org ENTRY_POINT

        ; Vstupní bod celého programu
start:
        call fill_in_screen      ; vyplnění obrazovky ASCII tabulkami
finito:
        jr finito                ; ukončit program nekonečnou smyčkou


fill_in_screen:
        ; Vyplnění obrazovky snadno rozpoznatelným vzorkem - ASCII tabulkami
        ;
        ; vstupy:
        ; žádné
        ld de, SCREEN_ADR         ; adresa pro vykreslení prvního bloku znaků
        call draw_ascii_table     ; vykreslení 96 znaků
        call draw_ascii_table     ; vykreslení 96 znaků

        ld hl, inv_instruction_adr; adresa bajtu v paměti, který budeme modifikovat
        ld (hl), NOP_INSTRUCTION  ; zápis instrukce NOP namísto instrukce CPL

        call draw_ascii_table     ; vykreslení 96 znaků
        call draw_ascii_table     ; vykreslení 96 znaků
        ret                       ; návrat z podprogramu


draw_ascii_table:
        ; Vytištění ASCII tabulky inverzně (barva inkoustu je barvou pozadí a naopak)
        ;       
        ; vstupy:
        ; DE - adresa v obrazové paměti pro vykreslení znaku
        ld a, ' '                ; kód vykreslovaného znaku
next_char:
        push af                  ; uschovat akumulátor na zásobník
        call draw_char           ; zavolat subrutinu pro vykreslení znaku
        ld a, ' '                ; vykreslit za znakem mezeru
        call draw_char           ; zavolat subrutinu pro vykreslení znaku
        pop af                   ; obnovit akumulátor ze zásobníku
        inc a                    ; ASCII kód dalšího znaku
        cp  ' ' + 96             ; jsme již na konci ASCII tabulky?
        jr nz, next_char         ; ne? potom pokračujeme
        ret                      ; návrat z podprogramu


draw_char:
        ; Vytištění jednoho inverzního znaku na obrazovku
        ;
        ; vstupy:
        ; A - kód znaku pro vykreslení
        ; DE - adresa v obrazové paměti pro vykreslení znaku
        ;
        ; výstupy:
        ; DE - adresa v obrazové paměti pro vykreslení dalšího znaku
        ;
        ; změněné registry:
        ; všechny
        ld bc, CHAR_ADR          ; adresa, od níž začínají masky znaků
        ld h, c                  ; C je nulové, protože CHAR_ADR=0x3c00
        ld l, a                  ; kód znaku je nyní ve dvojici HL

        add  hl, hl              ; 2x
        add  hl, hl              ; 4x
        add  hl, hl              ; 8x
        add  hl, bc              ; přičíst bázovou adresu masek znaků

        ld b, 8                  ; počitadlo zapsaných bajtů
        ld c, d

loop:
        ld   a,(hl)              ; načtení jednoho bajtu z masky
inv_instruction_adr:
        cpl                      ; negace hodnoty v akumulátoru
        ld   (de),a              ; zápis hodnoty na adresu (DE)
        inc  l                   ; posun na další bajt masky (nemusíme řešit přetečení do vyššího bajtu)
        inc  d                   ; posun na definici dalšího obrazového řádku
        djnz loop                ; vnitřní smyčka: blok s osmi zápisy
        inc  e
        ret  z                   ; D+=8,E=E+1=0
        ld   d, c
        ret                      ; D=D,E=E+1

end ENTRY_POINT
