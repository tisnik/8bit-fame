; Example that is used in following article:
;    Zobrazení čísel a zpracování příznaků mikroprocesoru Zilog Z80
;    https://www.root.cz/clanky/zobrazeni-cisel-a-zpracovani-priznaku-mikroprocesoru-zilog-z80/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #68:
;    Print flags after arithmetic operation 0+0.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/68-print-flags-2.asm



ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


        org ENTRY_POINT

start:
        call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)

        ld   A, 0       ; první sčítanec
        add  A, 0       ; druhý sčítance + výsledek operace

        push AF         ; uložíme pár AF na zásobník
        pop  BC         ; obnovíme původní obsah AF ze zásobníku, ovšem nyní do BC
        ld   B, 0       ; vymažeme B (což byl obsah A), ponecháme jen C (což byl obsah F)

        call OUT_NUM_1  ; zavolání rutiny pro výpis celého čísla

        ret             ; návrat z programu do BASICu

end ENTRY_POINT
