; ---------------------------------------------------------------------
; Kostra programu pro herní konzoli NES
; Nastavení barvové palety, zvýšení intenzity barvy
; Setup PPU přes makro
; Definice spritu a zobrazení spritů s rozloženým Mariem. Současné
; zobrazení většího množství spritů.
;
; Založeno na příkladu https://github.com/depp/ctnes/tree/master/nesdev/01
; Taktéž založeno na https://nerdy-nights.nes.science/#main_tutorial-3
; Viz též článek na https://www.moria.us/blog/2018/03/nes-development
; Audio https://raw.githubusercontent.com/iliak/nes/master/doc/apu_ref.txt
;
; Tento zdrojový kód je součástí seriálu Vývoj her pro herní konzoli NES
; https://www.root.cz/serialy/vyvoj-her-pro-herni-konzoli-nes/
; ---------------------------------------------------------------------

; Jména řídicích registrů použitých v kódu
PPUCTRL         = $2000
PPUMASK         = $2001
PPUSTATUS       = $2002
PPUADDR         = $2006
PPUDATA         = $2007
DMC_FREQ        = $4010
OAM_DMA         = $4014

; Další důležité adresy
PALETTE         = $3f00



; ---------------------------------------------------------------------
; Definice maker
; ---------------------------------------------------------------------

.macro setup_cpu
        ; nastavení stavu CPU
        sei                     ; zákaz přerušení
        cld                     ; vypnutí dekadického režimu (není podporován)

        ldx #$ff
        txs                     ; vrchol zásobníku nastaven na 0xff (první stránka)
.endmacro

.macro wait_for_frame
:       bit PPUSTATUS            ; test obsahu registru PPUSTATUS 
        bpl :-                   ; skok, pokud je příznak N nulový
.endmacro

.macro clear_ram
        lda #$00                ; vynulování registru A
:       sta $000, x             ; vynulování X-tého bajtu v nulté stránce
        sta $100, x
        sta $200, x
        sta $300, x
        sta $400, x
        sta $500, x
        sta $600, x
        sta $700, x             ; vynulování X-tého bajtu v sedmé stránce
        inx                     ; přechod na další bajt
        bne :-                  ; po přetečení 0xff -> 0x00 konec smyčky
.endmacro

.macro ppu_data_palette_address
        lda PPUSTATUS   ; reset záchytného registru
        lda #>PALETTE   ; nastavení adresy pro barvovou paletu $3f00
        sta PPUADDR
        lda #<PALETTE   ; nižší bajt adresy
        sta PPUADDR
.endmacro


; ---------------------------------------------------------------------
; Definice hlavičky obrazu ROM
; ---------------------------------------------------------------------

; Size of PRG in units of 16 KiB.
prg_npage = 2

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

.segment "ZEROPAGE"
.segment "STARTUP"
.segment "CODE"



; ---------------------------------------------------------------------
; Blok paměti s definicí dlaždic 8x8 pixelů
; ---------------------------------------------------------------------

.segment "CHR0a"
.segment "CHR0b"


.code

; ---------------------------------------------------------------------
; Programový kód rutin pro NMI, RESET a IRQ volaných automaticky CPU
;
; viz též https://www.pagetable.com/?p=410
; ---------------------------------------------------------------------

; Obslužná rutina pro NMI (nemaskovatelné přerušení, vertical blank)

.proc nmi
        lda #$02          ; horní bajt adresy pro přenos + zahájení přenosu
        sta OAM_DMA
        rti                     ; návrat z přerušení
.endproc



; Obslužná rutina pro IRQ (maskovatelné přerušení)

.proc irq
        rti                     ; návrat z přerušení
.endproc



; Obslužná rutina pro RESET

.proc reset
        ; nastavení stavu CPU
        setup_cpu

        ; nastavení řídicích registrů
        ldx #$00
        stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
        stx PPUMASK             ; nastavení PPUMASK = 0
        stx DMC_FREQ            ; zákaz DMC IRQ

        ldx #$40
        stx $4017               ; interrupt inhibit bit

        ; čekání na vnitřní inicializaci PPU (dva snímky)
        wait_for_frame
        wait_for_frame

        ; vymazání obsahu RAM
        clear_ram

        ; čekání na další snímek
        wait_for_frame

        ; nastavení barvové palety
        jsr load_palette  ; zavolání subrutiny

        ; nastavení spritů
        jsr load_sprites  ; zavolání subrutiny

        ; vlastní herní smyčka je prozatím prázdná
game_loop:
        jmp game_loop           ; nekonečná smyčka (později rozšíříme)
.endproc



; vynulování barvové palety
.proc clear_palette
        ppu_data_palette_address

        ldx #$20        ; počitadlo barev v paletě: 16+16
        lda #$00        ; vynulování každé barvy

:
        sta PPUDATA     ; zápis barvy
        dex             ; snížení hodnoty počitadla
        bne :-

        rts             ; návrat ze subrutiny
.endproc



; nastavení barvové palety
.proc load_palette
        ppu_data_palette_address

        ; $3f00-$3f0f - paleta pozadí
        ; $3f10-$3f1f - paleta spritů

        ldx #$00        ; vynulovat počitadlo a offset

:
        lda palette, x  ; načíst bajt s offsetem
        sta PPUDATA     ; zápis barvy do PPU
        inx             ; zvýšit počitadlo/offset
        cpx #32         ; limit počtu barev
        bne :-          ; opakovat smyčku 32x

        rts             ; návrat ze subrutiny
.endproc



; načtení spritů
.proc load_sprites
        ldx #0
:
        lda spritedata,X  ; budeme přesouvat data z této oblasti
        sta $0200,X       ; uložení do paměti spritů
        inx               ; zvýšení hodnoty počitadla
        cpx #160          ; každý sprite má 4 bajty: y-coord, tile, attributy, y-coord * 8 spritů = 32
                          ; * 5 postaviček = 160 bajtů
        bne :-

        cli               ; vynulování bitu I - povolení přerušení
        lda #%10000000      
        sta PPUCTRL       ; při každém VBLANK se vyvolá NMI (důležité!)

        lda #%00010000    ; povolení zobrazení spritů
        sta PPUMASK

        rts               ; návrat ze subrutiny
.endproc



; samotná barvová paleta
palette:
    .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
    .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů

; data pro větší množství spritů
spritedata:
    .byte $10, $00, $00, $08   ; y-coord, tile number, attributes, x-coord
    .byte $10, $01, $00, $10
    .byte $18, $02, $00, $08
    .byte $18, $03, $00, $10
    .byte $20, $04, $00, $08
    .byte $20, $05, $00, $10
    .byte $28, $06, $00, $08
    .byte $28, $07, $00, $10

    .byte $10, $08, $00, $28   ; y-coord, tile number, attributes, x-coord
    .byte $10, $09, $00, $30
    .byte $18, $0a, $00, $28
    .byte $18, $0b, $00, $30
    .byte $20, $0c, $00, $28
    .byte $20, $0d, $00, $30
    .byte $28, $0d, $00, $28
    .byte $28, $0f, $00, $30

    .byte $10, $10, $00, $48   ; y-coord, tile number, attributes, x-coord
    .byte $10, $11, $00, $50
    .byte $18, $12, $00, $48
    .byte $18, $13, $00, $50
    .byte $20, $14, $00, $48
    .byte $20, $15, $00, $50
    .byte $28, $16, $00, $48
    .byte $28, $17, $00, $50

    .byte $30, $18, $00, $68   ; y-coord, tile number, attributes, x-coord
    .byte $30, $19, $00, $70
    .byte $38, $1a, $00, $68
    .byte $38, $1b, $00, $70
    .byte $40, $1c, $00, $68
    .byte $40, $1d, $00, $70
    .byte $48, $1e, $00, $68
    .byte $48, $1f, $00, $70

    .byte $10, $10, $00, $88   ; y-coord, tile number, attributes, x-coord
    .byte $10, $11, $00, $90
    .byte $18, $12, $00, $88
    .byte $18, $13, $00, $90
    .byte $20, $14, $00, $88
    .byte $20, $15, $00, $90
    .byte $28, $16, $00, $88
    .byte $28, $17, $00, $90



; ---------------------------------------------------------------------
; Tabulka vektorů CPU
; ---------------------------------------------------------------------

.segment "VECTORS"
.addr nmi
.addr reset
.addr irq



.segment "CHARS"
    .incbin "mario.chr"



; ---------------------------------------------------------------------
; Finito
; ---------------------------------------------------------------------
