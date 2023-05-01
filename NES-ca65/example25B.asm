; ---------------------------------------------------------------------
; Kostra programu pro herní konzoli NES
; Nastavení barvové palety, zvýšení intenzity barvy
; Setup PPU přes makro
; Definice pozadí a zobrazení pozadí
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
NAME_TABLE_0    = $2000
ATTRIB_TABLE_0  = $23c0



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
        rti               ; návrat z přerušení
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
        ldx #$40
        stx $4017               ; zákaz IRQ z APU

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

        ; nastavení tabulek jmen
        jsr clear_nametables  ; zavolání subrutiny 

        ; nastavení barvové palety
        jsr load_palette      ; zavolání subrutiny

        ; načtení tabulky jmen
        jsr load_nametable    ; zavolání subrutiny

        ; načtení atributů
        jsr load_attributes   ; zavolání subrutiny

        cli                   ; vynulování bitu I - povolení přerušení
        lda #%10010000      
        sta PPUCTRL           ; při každém VBLANK se vyvolá NMI (důležité!)

        lda #%00001110        ; povolení zobrazení pozadí, nikoli ovšem spritů
        sta PPUMASK

        ; vlastní herní smyčka je prozatím prázdná
game_loop:
        jmp game_loop           ; nekonečná smyčka (později rozšíříme)
.endproc



; vynulování tabulek jmen
.proc clear_nametables
        lda PPUSTATUS      ; reset záchytného registru
        lda #>NAME_TABLE_0 ; horní bajt adresy
        sta PPUADDR
        lda #<NAME_TABLE_0 ; spodní bajt adresy
        sta PPUADDR
        ldx #$08           ; počitadlo stránek (8)
        ldy #$00           ; X a Y tvoří 16bitový čítač
        lda #$24           ; dlaždice číslo $24 představuje oblohu
:
        sta PPUDATA        ; zápis indexu dlaždice
        dey                ; snížení hodnoty počitadla
        bne :-             ; skok dokud se nezaplní celá stránka
        dex                ; snížení hodnoty počitadla stránek
        bne :-             ; skok dokud se nezaplní 8 stránek

        rts                ; návrat ze subrutiny
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



; načtení tabulky jmen
.proc load_nametable
        lda PPUSTATUS      ; reset záchytného registru
        lda #>NAME_TABLE_0 ; horní bajt adresy
        sta PPUADDR
        lda #<NAME_TABLE_0 ; spodní bajt adresy
        sta PPUADDR

        ldx #$00           ; počitadlo
:
        txa
        sta PPUDATA        ; zápis indexu dlaždice
        inx 
        bne :-

        rts                ; návrat ze subrutiny
.endproc



; načtení atributů
.proc load_attributes
        lda PPUSTATUS        ; reset záchytného registru
        lda #>ATTRIB_TABLE_0 ; horní bajt adresy $23c0
        sta PPUADDR
        lda #<ATTRIB_TABLE_0 ; spodní bajt adresy $23c0
        sta PPUADDR
        ldx #$00             ; počitadlo smyčky
:
        lda attributedata,X
        sta PPUDATA          ; zápis indexu
        inx                  ; zvýšení hodnoty počitadla
        cpx #$08             ; provádíme kopii osmi bajtů
        bne :-

        rts                  ; návrat ze subrutiny
.endproc



; samotná barvová paleta
palette:
    .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
    .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů


; tabulka jmen
nametabledata:
    .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; první řádek: nebe
    .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24

    .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; druhý řádek: nebe
    .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24

    .byte $24,$24,$24,$24,$45,$45,$24,$24,$45,$45,$45,$45,$45,$45,$24,$24  ; třetí řádek
    .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24  ; různé cihly (horní polovina)

    .byte $24,$24,$24,$24,$47,$47,$24,$24,$47,$47,$47,$47,$47,$47,$24,$24  ; čtvrtý řádek
    .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24  ; různé cihly (spodní polovina)


; tabulka atributů
attributedata:
    .byte %00000000, %00010000, %00100000, %00000000, %00000000, %00000000, %00000000, %00110000



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
