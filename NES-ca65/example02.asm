; ---------------------------------------------------------------------
; Neoptimalizovaná kostra programu pro herní konzoli NES
; Použití standardního nastavení segmentů podle ca65 (cc65)
;
; Založeno na příkladu https://github.com/depp/ctnes/tree/master/nesdev/01
; Viz též článek na https://www.moria.us/blog/2018/03/nes-development
;
; Tento zdrojový kód je součástí seriálu Vývoj her pro herní konzoli NES
; https://www.root.cz/serialy/vyvoj-her-pro-herni-konzoli-nes/
; ---------------------------------------------------------------------

; ---------------------------------------------------------------------
; Definice hlavičky obrazu ROM
; ---------------------------------------------------------------------

; Size of PRG in units of 16 KiB.
prg_npage = 1

; Size of CHR in units of 8 KiB.
chr_npage = 1

; INES mapper number.
mapper = 0

; Mirroring (0 = horizontal, 1 = vertical)
mirroring = 1

.segment "HEADER"
        .byte $4e, $45, $53, $1a
        .byte prg_npage
        .byte chr_npage
        .byte ((mapper & $0f) << 4) | (mirroring & 1)
        .byte mapper & $f0


; ---------------------------------------------------------------------
; Blok paměti s definicí dlaždic 8x8 pixelů
; ---------------------------------------------------------------------

.segment "CHARS"



.code

; ---------------------------------------------------------------------
; Programový kód rutin pro NMI, RESET a IRQ volaných automaticky CPU
;
; viz též https://www.pagetable.com/?p=410
; ---------------------------------------------------------------------

; Obslužná rutina pro NMI (nemaskovatelné přerušení, vertical blank)

.proc nmi
        rti                     ; návrat z přerušení
.endproc



; Obslužná rutina pro IRQ (maskovatelné přerušení)

.proc irq
        rti                     ; návrat z přerušení
.endproc



; Obslužná rutina pro RESET

.proc reset
        ; nastavení stavu CPU
        sei                     ; zákaz přerušení
        cld                     ; vypnutí dekadického režimu (není podporován)

        ldx #$ff
        txs                     ; vrchol zásobníku nastaven na 0xff (první stránka)

        ; nastavení řídicích registrů
        ldx #$00
        stx $2000               ; nastavení PPUCTRL = 0
        stx $2001               ; nastavení PPUMASK = 0
        stx $4015               ; nastavení APUSTATUS = 0

        ; čekání na vnitřní inicializaci PPU (dva snímky)
wait1:  bit $2002               ; test obsahu registru PPUSTATUS 
        bpl wait1               ; skok, pokud je příznak N nulový
wait2:  bit $2002               ; test obsahu registru PPUSTATUS 
        bpl wait2               ; skok, pokud je příznak N nulový

        ; vymazání obsahu RAM
        lda #$00                ; vynulování registru A
loop:   sta $000, x             ; vynulování X-tého bajtu v nulté stránce
        sta $100, x
        sta $200, x
        sta $300, x
        sta $400, x
        sta $500, x
        sta $600, x
        sta $700, x             ; vynulování X-tého bajtu v sedmé stránce
        inx                     ; přechod na další bajt
        bne loop                ; po přetečení 0xff -> 0x00 konec smyčky

        ; čekání na dokončení dalšího snímku, potom může začít herní smyčka
wait3:  bit $2002               ; test obsahu registru PPUSTATUS 
        bpl wait3               ; skok, pokud je příznak N nulový

        ; vlastní herní smyčka je prozatím prázdná
game_loop:
        jmp game_loop           ; nekonečná smyčka (později rozšíříme)
.endproc



; ---------------------------------------------------------------------
; Tabulka vektorů CPU
; ---------------------------------------------------------------------

.segment "VECTORS"
.addr nmi
.addr reset
.addr irq



.segment "STARTUP"

; ---------------------------------------------------------------------
; Finito
; ---------------------------------------------------------------------
