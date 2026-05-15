; ---------------------------------------------------------------------
; ---------------------------------------------------------------------

.include "atari.inc"

.CODE



; ---------------------------------------------------------------------
; makro pro vyplnění obrazovky znaky
; ---------------------------------------------------------------------
.macro  fill_screen screen
        .local clear            ; definice lokálního symbolu
        ldy #0                  ; počitadlo zápisů
clear:
        tya                     ; kód vypisovaného znaku
        sta screen, y           ; tisk znaku na zvolené místo na obrazovce
        sta screen+40*8, y
        sta screen+40*16, y
        iny                     ; zvětšit hodnotu počitadla a offsetu
        cpy #$80
        bne clear               ; skok
.endmacro


; ---------------------------------------------------------------------
; makro pro nastavení display listu
; ---------------------------------------------------------------------
.macro  set_display_list label
        lda #<label             ; nižší byte adresy display listu
        sta SDLSTL
        lda #>label             ; vyšší byte adresy display listu
        sta SDLSTH
.endmacro


; ---------------------------------------------------------------------
; makro pro nastavení VBI
; ---------------------------------------------------------------------
.macro  set_vbi_handler handler
        ; nastavit vektor pro odloženou VBI
        lda #7                  ; změna vektoru pro odložené VBI
        ldx #>handler
        ldy #<handler
        jsr SETVBV              ; zavolat službu systému pro nastavení vektoru
.endmacro


; ---------------------------------------------------------------------
; makro pro tisk jedné hexa číslice na určené místo na obrazovce
; ---------------------------------------------------------------------
.macro  print_hex address, screen, offset
        .local skip_add         ; definice lokálního symbolu
        lda address             ; načíst hodnotu, která se má vypsat
        lsr A                   ; 4x "zpomalení"
        lsr A
        and #15                 ; scrolling je jen v rozsahu 0-15
        cmp #$0a                ; test na hodnotu 0-9 nebo 10-15
        bcc skip_add            ; je to hodnota 0-9?
        adc #6                  ; pricist sedmicku (6+carry)
skip_add:
        adc #16                 ; prevod hodnoty na interni kod (ne ATASCII!)
        sta screen+offset
.endmacro


; ---------------------------------------------------------------------
; hlavní herní smyčka
; ---------------------------------------------------------------------
.macro  game_loop
        .local loop             ; definice lokálního symbolu
loop:
        jmp loop                ; program vlastně nice nedělá - jen cyklí!
.endmacro


; ---------------------------------------------------------------------
; vstupní bod do programu
; ---------------------------------------------------------------------
.proc main
        set_display_list dlist  ; nastavení display listu
        fill_screen screen      ; výpis znaků na obrazovku
        set_vbi_handler scroll  ; nastavení obsluhy VBI
        game_loop               ; hlavní herní smyčka
.endproc


; ---------------------------------------------------------------------
; subrutina pro obsluhu VBI
; ---------------------------------------------------------------------
.proc   scroll
        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dec x_scroll            ; změnit počitadlo horizontálního scrollingu
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inc x_scroll            ; změnit počitadlo horizontálního scrollingu
not_right:
        cmp #14                 ; je nakloněn nahoru?
        bne not_up
        dec y_scroll            ; změnit počitadlo vertikálního scrollingu
not_up:
        cmp #13                 ; je nakloněn dolů?
        bne not_down
        inc y_scroll            ; změnit počitadlo vertikálního scrollingu
not_down:
        lda x_scroll            ; změna horizontálního posunu
        lsr A                   ; 4x "zpomalení"
        lsr A
        sta HSCROL              ; zápis do řídicího registru ANTICu

        lda y_scroll            ; změna vertikálního posunu
        lsr A                   ; 4x "zpomalení"
        lsr A
        sta VSCROL              ; zápis do řídicího registru ANTICu

        print_hex x_scroll, screen, 40*23
        print_hex y_scroll, screen, 40*23+2
        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
.endproc


dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x1       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 11, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.res 6,  DL_HSCROL+DL_VSCROL+DL_CHR40x8x1 ; zde bude povolen scrolling
.res 6,  DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu


color:
.byte $c4                       ; původní barva


; horizontální scrolling
x_scroll:    .byte 0

; vertikální scrolling
y_scroll:    .byte 0

end:


.BSS
screen: .res 40*24

.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   main                    ; zacatek kodoveho segmentu
.word   end - 1                 ; konec kodoveho segmentu


.segment "AUTOSTRT"             ; segment s pocatecni adresou
.word   RUNAD                   ; naplni se pouze adresy RUNAD a RUNAD+1
.word   RUNAD+1
.word   main                    ; adresa vstupniho bodu do programu

; finito
