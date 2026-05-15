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
        ldx x_scroll            ; původní pozice prvního hráče

        lda STICK0              ; čtení joysticku
        cmp #11                 ; je nakloněn doleva?
        bne not_left
        dex                     ; posun hráče doleva
not_left:
        cmp #7                  ; je nakloněn doprava?
        bne not_right
        inx                     ; posun hráče doprava
not_right:
        stx x_scroll            ; zapamatovat si pozici prvního hráče
        ; scrolling
        jmp XITVBV              ; zpracovat zbytek odloženého VBLANKu
.endproc


dlist:
.byte DL_BLK8, DL_BLK8, DL_BLK8 ; 3x8=24 prázdných obrazových řádků
.byte DL_LMS+DL_CHR40x8x1       ; určení počáteční adresy obrazové paměti + jeden řádek režimu 2 (GR.0)
.byte <screen, >screen          ; počáteční adresa obrazové paměti 
.res 23, DL_CHR40x8x1           ; opakovat řádky textového režimu 2 (GR.0)
.byte DL_JVB, <dlist, >dlist    ; skok na začátek display listu


color:
.byte $c4                       ; původní barva


; horizontální scrolling
x_scroll:    .byte 0

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
