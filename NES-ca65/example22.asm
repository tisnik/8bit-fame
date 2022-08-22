; ---------------------------------------------------------------------
; Kostra programu pro herní konzoli NES
; Nastavení barvové palety, zvýšení intenzity barvy
; Setup PPU přes makro
; Definice spritu a zobrazení spritů s rozloženým Mariem.
; Pohyb celého Maria.
; Využití symbolických jmen adres.
; Pomocná makra pro pohyb spritu.
; Změna dalších vlastností spritů s využitím tlačítek A a B
;
; Založeno na příkladu https://github.com/depp/ctnes/tree/master/nesdev/01
; Taktéž založeno na https://nerdy-nights.nes.science/#main_tutorial-3
; Viz též článek na https://www.moria.us/blog/2018/03/nes-development
; Audio https://raw.githubusercontent.com/iliak/nes/master/doc/apu_ref.txt
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

; Ovladače
JOYPAD1         = $4016
JOYPAD2         = $4017



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

.macro increment_block address, count, gap
        ldx #0             ; inicializace offsetu
:
        inc address, x     ; zvýšit pozici spritu o jedničku

	txa                ; přesun offsetu do akumulátoru
	clc
	adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
	tax                ; přesun nového offsetu zpět do registru X

	cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu

        bne :-             ; pokud ne, skok na začátek smyčky
.endmacro

.macro decrement_block address, count, gap
        ldx #0             ; inicializace offsetu
:
        dec address, x     ; zvýšit pozici spritu o jedničku

	txa                ; přesun offsetu do akumulátoru
	clc
	adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
	tax                ; přesun nového offsetu zpět do registru X

	cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu

        bne :-             ; pokud ne, skok na začátek smyčky
.endmacro

.macro increment_block_mask address, count, gap, mask
        ldx #0             ; inicializace offsetu
:
        inc address, x     ; zvýšit pozici spritu o jedničku

	lda address, x     ; maskování hodnoty
	and #mask
	sta address, x

	txa                ; přesun offsetu do akumulátoru
	clc
	adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
	tax                ; přesun nového offsetu zpět do registru X

	cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu

        bne :-             ; pokud ne, skok na začátek smyčky
.endmacro

.macro read_button
        lda JOYPAD1        ; stav tlačítka
        and #%00000001     ; maskovat všechny bity kromě prvního
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
        lda #$02           ; horní bajt adresy pro přenos + zahájení přenosu
        sta OAM_DMA

        lda #$01
        sta JOYPAD1        ; načtení stavu všech osmi tlačítek do záchytného registru
        lda #$00
        sta JOYPAD1        ; začátek načítání jednotlivých bitů se stavy tlačítek v tomto pořadí:
                           ; 
                           ; 1) A                      
                           ; 2) B                      
                           ; 3) Select                 
                           ; 4) Start                  
                           ; 5) Up                     
                           ; 6) Down                   
                           ; 7) Left                   
                           ; 8) Right

        XPOS = $0203       ; adresa buňky paměti s x-ovou souřadnicí spritu
        YPOS = $0200       ; adresa buňky paměti y x-ovou souřadnicí spritu
	ATTRS = $0202      ; adresa buňky paměti s atributy spritu

        read_button        ; stisk tlačítka A bude sloužit pro přepínání barvy spritů
        beq button_a_not_pressed ; není stisknuto? => skok

        increment_block_mask ATTRS, 8, 4, 3

button_a_not_pressed:

        read_button        ; stav tlačítka B jen načteme a ingorujeme
        read_button        ; stav tlačítka Select jen načteme a ingorujeme
        read_button        ; stav tlačítka Start jen načteme a ingorujeme

        read_button        ; stav tlačítka Up
        beq up_not_pressed ; není stisknuto? => skok

        decrement_block YPOS, 8, 4

up_not_pressed:

        read_button        ; stav tlačítka Down
        beq down_not_pressed ; není stisknuto? => skok

        increment_block YPOS, 8, 4

down_not_pressed:

        read_button      ; stav tlačítka Left
        beq left_not_pressed ; není stisknuto? => skok

        decrement_block XPOS, 8, 4

left_not_pressed:

        read_button      ; stav tlačítka Right
        beq right_not_pressed ; není stisknuto? => skok

        increment_block XPOS, 8, 4

right_not_pressed:

        rti                ; návrat z přerušení

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
        cpx #32           ; každý sprite má 4 bajty: y-coord, tile, attributy, y-coord * 8 spritů = 32
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
