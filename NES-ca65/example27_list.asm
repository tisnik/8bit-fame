ca65 V2.18 - Ubuntu 2.18-1
Main file   : example27.asm
Current file: example27.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity barvy
000000r 1               ; Setup PPU přes makro
000000r 1               ; Definice spritu a zobrazení spritů s Mariem
000000r 1               ; Definice pozadí a zobrazení pozadí
000000r 1               ; Využití symbolických jmen adres.
000000r 1               ; Pomocná makra pro pohyb spritu.
000000r 1               ; Změna dalších vlastností spritů s využitím tlačítek A a B
000000r 1               ;
000000r 1               ; Založeno na příkladu https://github.com/depp/ctnes/tree/master/nesdev/01
000000r 1               ; Taktéž založeno na https://nerdy-nights.nes.science/#main_tutorial-3
000000r 1               ; Viz též článek na https://www.moria.us/blog/2018/03/nes-development
000000r 1               ; Audio https://raw.githubusercontent.com/iliak/nes/master/doc/apu_ref.txt
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               ; Jména řídicích registrů použitých v kódu
000000r 1               PPUCTRL         = $2000
000000r 1               PPUMASK         = $2001
000000r 1               PPUSTATUS       = $2002
000000r 1               PPUADDR         = $2006
000000r 1               PPUDATA         = $2007
000000r 1               DMC_FREQ        = $4010
000000r 1               OAM_DMA         = $4014
000000r 1               
000000r 1               ; Další důležité adresy
000000r 1               PALETTE         = $3f00
000000r 1               NAME_TABLE_0    = $2000
000000r 1               ATTRIB_TABLE_0  = $23c0
000000r 1               
000000r 1               ; Ovladače
000000r 1               JOYPAD1         = $4016
000000r 1               JOYPAD2         = $4017
000000r 1               
000000r 1               ; Čítače
000000r 1               COUNTER1        = $00fe
000000r 1               COUNTER2        = $00ff
000000r 1               
000000r 1               
000000r 1               
000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Definice maker
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               .macro setup_cpu
000000r 1                       ; nastavení stavu CPU
000000r 1                       sei                     ; zákaz přerušení
000000r 1                       cld                     ; vypnutí dekadického režimu (není podporován)
000000r 1               
000000r 1                       ldx #$ff
000000r 1                       txs                     ; vrchol zásobníku nastaven na 0xff (první stránka)
000000r 1               .endmacro
000000r 1               
000000r 1               .macro wait_for_frame
000000r 1               :       bit PPUSTATUS            ; test obsahu registru PPUSTATUS
000000r 1                       bpl :-                   ; skok, pokud je příznak N nulový
000000r 1               .endmacro
000000r 1               
000000r 1               .macro clear_ram
000000r 1                       lda #$00                ; vynulování registru A
000000r 1               :       sta $000, x             ; vynulování X-tého bajtu v nulté stránce
000000r 1                       sta $100, x
000000r 1                       sta $200, x
000000r 1                       sta $300, x
000000r 1                       sta $400, x
000000r 1                       sta $500, x
000000r 1                       sta $600, x
000000r 1                       sta $700, x             ; vynulování X-tého bajtu v sedmé stránce
000000r 1                       inx                     ; přechod na další bajt
000000r 1                       bne :-                  ; po přetečení 0xff -> 0x00 konec smyčky
000000r 1               .endmacro
000000r 1               
000000r 1               .macro ppu_data_palette_address
000000r 1                       lda PPUSTATUS   ; reset záchytného registru
000000r 1                       lda #>PALETTE   ; nastavení adresy pro barvovou paletu $3f00
000000r 1                       sta PPUADDR
000000r 1                       lda #<PALETTE   ; nižší bajt adresy
000000r 1                       sta PPUADDR
000000r 1               .endmacro
000000r 1               
000000r 1               .macro increment_block address, count, gap
000000r 1                       ldx #0             ; inicializace offsetu
000000r 1               :
000000r 1                       inc address, x     ; zvýšit pozici spritu o jedničku
000000r 1               
000000r 1                       txa                ; přesun offsetu do akumulátoru
000000r 1                       clc
000000r 1                       adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
000000r 1                       tax                ; přesun nového offsetu zpět do registru X
000000r 1               
000000r 1                       cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu
000000r 1               
000000r 1                       bne :-             ; pokud ne, skok na začátek smyčky
000000r 1               .endmacro
000000r 1               
000000r 1               .macro decrement_block address, count, gap
000000r 1                       ldx #0             ; inicializace offsetu
000000r 1               :
000000r 1                       dec address, x     ; zvýšit pozici spritu o jedničku
000000r 1               
000000r 1                       txa                ; přesun offsetu do akumulátoru
000000r 1                       clc
000000r 1                       adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
000000r 1                       tax                ; přesun nového offsetu zpět do registru X
000000r 1               
000000r 1                       cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu
000000r 1               
000000r 1                       bne :-             ; pokud ne, skok na začátek smyčky
000000r 1               .endmacro
000000r 1               
000000r 1               .macro increment_block_mask address, count, gap, mask
000000r 1                       ldx #0             ; inicializace offsetu
000000r 1               :
000000r 1                       inc address, x     ; zvýšit pozici spritu o jedničku
000000r 1               
000000r 1                       lda address, x     ; maskování hodnoty
000000r 1                       and #mask
000000r 1                       sta address, x
000000r 1               
000000r 1                       txa                ; přesun offsetu do akumulátoru
000000r 1                       clc
000000r 1                       adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
000000r 1                       tax                ; přesun nového offsetu zpět do registru X
000000r 1               
000000r 1                       cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu
000000r 1               
000000r 1                       bne :-             ; pokud ne, skok na začátek smyčky
000000r 1               .endmacro
000000r 1               
000000r 1               .macro flip_bit_block address, count, gap, mask
000000r 1                       ldx #0             ; inicializace offsetu
000000r 1               :
000000r 1                       lda address, x     ; maskování hodnoty
000000r 1                       eor #mask
000000r 1                       sta address, x
000000r 1               
000000r 1                       txa                ; přesun offsetu do akumulátoru
000000r 1                       clc
000000r 1                       adc #gap           ; zvýšení o hodnotu gap (4, další sprite)
000000r 1                       tax                ; přesun nového offsetu zpět do registru X
000000r 1               
000000r 1                       cmp #count*gap     ; porovnání, zda jsme již dosáhli posledního spritu
000000r 1               
000000r 1                       bne :-             ; pokud ne, skok na začátek smyčky
000000r 1               .endmacro
000000r 1               
000000r 1               .macro read_button
000000r 1                       lda JOYPAD1        ; stav tlačítka
000000r 1                       and #%00000001     ; maskovat všechny bity kromě prvního
000000r 1               .endmacro
000000r 1               
000000r 1               
000000r 1               
000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Definice hlavičky obrazu ROM
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               ; Size of PRG in units of 16 KiB.
000000r 1               prg_npage = 2
000000r 1               
000000r 1               ; Size of CHR in units of 8 KiB.
000000r 1               chr_npage = 1
000000r 1               
000000r 1               ; INES mapper number.
000000r 1               mapper = 0
000000r 1               
000000r 1               ; Mirroring (0 = horizontal, 1 = vertical)
000000r 1               mirroring = 1
000000r 1               
000000r 1               .segment "HEADER"
000000r 1  4E 45 53 1A          .byte $4e, $45, $53, $1a
000004r 1  02                   .byte prg_npage
000005r 1  01                   .byte chr_npage
000006r 1  01                   .byte ((mapper & $0f) << 4) | (mirroring & 1)
000007r 1  00                   .byte mapper & $f0
000008r 1               
000008r 1               .segment "ZEROPAGE"
000000r 1               .segment "STARTUP"
000000r 1               .segment "CODE"
000000r 1               
000000r 1               
000000r 1               
000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Blok paměti s definicí dlaždic 8x8 pixelů
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               .segment "CHR0a"
000000r 1               .segment "CHR0b"
000000r 1               
000000r 1               
000000r 1               .code
000000r 1               
000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Programový kód rutin pro NMI, RESET a IRQ volaných automaticky CPU
000000r 1               ;
000000r 1               ; viz též https://www.pagetable.com/?p=410
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               ; Obslužná rutina pro NMI (nemaskovatelné přerušení, vertical blank)
000000r 1               
000000r 1               .proc nmi
000000r 1  A9 02                lda #$02           ; horní bajt adresy pro přenos + zahájení přenosu
000002r 1  8D 14 40             sta OAM_DMA
000005r 1               
000005r 1  A9 01                lda #$01
000007r 1  8D 16 40             sta JOYPAD1        ; načtení stavu všech osmi tlačítek do záchytného registru
00000Ar 1  A9 00                lda #$00
00000Cr 1  8D 16 40             sta JOYPAD1        ; začátek načítání jednotlivých bitů se stavy tlačítek v tomto pořadí:
00000Fr 1                                          ;
00000Fr 1                                          ; 1) A
00000Fr 1                                          ; 2) B
00000Fr 1                                          ; 3) Select
00000Fr 1                                          ; 4) Start
00000Fr 1                                          ; 5) Up
00000Fr 1                                          ; 6) Down
00000Fr 1                                          ; 7) Left
00000Fr 1                                          ; 8) Right
00000Fr 1               
00000Fr 1                       XPOS = $0203       ; adresa buňky paměti s x-ovou souřadnicí spritu
00000Fr 1                       YPOS = $0200       ; adresa buňky paměti y x-ovou souřadnicí spritu
00000Fr 1                       ATTRS = $0202      ; adresa buňky paměti s atributy spritu
00000Fr 1               
00000Fr 1  AD 16 40 29          read_button        ; stisk tlačítka A bude sloužit pro přepínání barvy spritů
000013r 1  01           
000014r 1  F0 1E                beq button_a_not_pressed ; není stisknuto? => skok
000016r 1               
000016r 1  C6 FE                dec COUNTER1
000018r 1  D0 1A                bne button_a_not_pressed
00001Ar 1               
00001Ar 1  A9 0A                lda #10
00001Cr 1  85 FE                sta COUNTER1
00001Er 1               
00001Er 1  A2 00 FE 02          increment_block_mask ATTRS, 8, 4, 3
000022r 1  02 BD 02 02  
000026r 1  29 03 9D 02  
00002Ar 1  02 8A 18 69  
00002Er 1  04 AA C9 20  
000032r 1  D0 EC        
000034r 1               
000034r 1               button_a_not_pressed:
000034r 1               
000034r 1  AD 16 40 29          read_button        ; stisk tlačítka B bude sloužit pro přepínání atributů spritů
000038r 1  01           
000039r 1  F0 1B                beq button_b_not_pressed ; není stisknuto? => skok
00003Br 1               
00003Br 1  C6 FF                dec COUNTER2
00003Dr 1  D0 17                bne button_b_not_pressed
00003Fr 1               
00003Fr 1  A9 0A                lda #10
000041r 1  85 FF                sta COUNTER2
000043r 1               
000043r 1  A2 00 BD 02          flip_bit_block ATTRS, 8, 4, %00100000
000047r 1  02 49 20 9D  
00004Br 1  02 02 8A 18  
00004Fr 1  69 04 AA C9  
000053r 1  20 D0 EF     
000056r 1               
000056r 1               button_b_not_pressed:
000056r 1               
000056r 1  AD 16 40 29          read_button        ; stisk tlačítka Select bude sloužit pro přepínání atributů spritů
00005Ar 1  01           
00005Br 1  F0 1B                beq button_select_not_pressed ; není stisknuto? => skok
00005Dr 1               
00005Dr 1  C6 FF                dec COUNTER2
00005Fr 1  D0 17                bne button_select_not_pressed
000061r 1               
000061r 1  A9 0A                lda #10
000063r 1  85 FF                sta COUNTER2
000065r 1               
000065r 1  A2 00 BD 02          flip_bit_block ATTRS, 8, 4, %10000000
000069r 1  02 49 80 9D  
00006Dr 1  02 02 8A 18  
000071r 1  69 04 AA C9  
000075r 1  20 D0 EF     
000078r 1               
000078r 1               button_select_not_pressed:
000078r 1               
000078r 1  AD 16 40 29          read_button        ; stav tlačítka Start jen načteme a ingorujeme
00007Cr 1  01           
00007Dr 1               
00007Dr 1  AD 16 40 29          read_button        ; stav tlačítka Up
000081r 1  01           
000082r 1  F0 0E                beq up_not_pressed ; není stisknuto? => skok
000084r 1               
000084r 1  A2 00 DE 00          decrement_block YPOS, 8, 4
000088r 1  02 8A 18 69  
00008Cr 1  04 AA C9 20  
000090r 1  D0 F4        
000092r 1               
000092r 1               up_not_pressed:
000092r 1               
000092r 1  AD 16 40 29          read_button        ; stav tlačítka Down
000096r 1  01           
000097r 1  F0 0E                beq down_not_pressed ; není stisknuto? => skok
000099r 1               
000099r 1  A2 00 FE 00          increment_block YPOS, 8, 4
00009Dr 1  02 8A 18 69  
0000A1r 1  04 AA C9 20  
0000A5r 1  D0 F4        
0000A7r 1               
0000A7r 1               down_not_pressed:
0000A7r 1               
0000A7r 1  AD 16 40 29          read_button      ; stav tlačítka Left
0000ABr 1  01           
0000ACr 1  F0 0E                beq left_not_pressed ; není stisknuto? => skok
0000AEr 1               
0000AEr 1  A2 00 DE 03          decrement_block XPOS, 8, 4
0000B2r 1  02 8A 18 69  
0000B6r 1  04 AA C9 20  
0000BAr 1  D0 F4        
0000BCr 1               
0000BCr 1               left_not_pressed:
0000BCr 1               
0000BCr 1  AD 16 40 29          read_button      ; stav tlačítka Right
0000C0r 1  01           
0000C1r 1  F0 0E                beq right_not_pressed ; není stisknuto? => skok
0000C3r 1               
0000C3r 1  A2 00 FE 03          increment_block XPOS, 8, 4
0000C7r 1  02 8A 18 69  
0000CBr 1  04 AA C9 20  
0000CFr 1  D0 F4        
0000D1r 1               
0000D1r 1               right_not_pressed:
0000D1r 1               
0000D1r 1  40                   rti                ; návrat z přerušení
0000D2r 1               
0000D2r 1               .endproc
0000D2r 1               
0000D2r 1               
0000D2r 1               
0000D2r 1               ; Obslužná rutina pro IRQ (maskovatelné přerušení)
0000D2r 1               
0000D2r 1               .proc irq
0000D2r 1  40                   rti                     ; návrat z přerušení
0000D3r 1               .endproc
0000D3r 1               
0000D3r 1               
0000D3r 1               
0000D3r 1               ; Obslužná rutina pro RESET
0000D3r 1               
0000D3r 1               .proc reset
0000D3r 1                       ; nastavení stavu CPU
0000D3r 1  78 D8 A2 FF          setup_cpu
0000D7r 1  9A           
0000D8r 1               
0000D8r 1                       ; nastavení řídicích registrů
0000D8r 1  A2 40                ldx #$40
0000DAr 1  8E 17 40             stx $4017               ; zákaz IRQ z APU
0000DDr 1               
0000DDr 1  A2 00                ldx #$00
0000DFr 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
0000E2r 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
0000E5r 1  8E 10 40             stx DMC_FREQ            ; zákaz DMC IRQ
0000E8r 1               
0000E8r 1  A2 40                ldx #$40
0000EAr 1  8E 17 40             stx $4017               ; interrupt inhibit bit
0000EDr 1               
0000EDr 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
0000EDr 1  2C 02 20 10          wait_for_frame
0000F1r 1  FB           
0000F2r 1  2C 02 20 10          wait_for_frame
0000F6r 1  FB           
0000F7r 1               
0000F7r 1                       ; vymazání obsahu RAM
0000F7r 1  A9 00 95 00          clear_ram
0000FBr 1  9D 00 01 9D  
0000FFr 1  00 02 9D 00  
000103r 1  03 9D 00 04  
000107r 1  9D 00 05 9D  
00010Br 1  00 06 9D 00  
00010Fr 1  07 E8 D0 E6  
000113r 1               
000113r 1                       ; čekání na další snímek
000113r 1  2C 02 20 10          wait_for_frame
000117r 1  FB           
000118r 1               
000118r 1                       ; nastavení tabulek jmen
000118r 1  20 rr rr             jsr clear_nametables  ; zavolání subrutiny
00011Br 1               
00011Br 1                       ; nastavení barvové palety
00011Br 1  20 rr rr             jsr load_palette      ; zavolání subrutiny
00011Er 1               
00011Er 1                       ; nastavení spritů
00011Er 1  20 rr rr             jsr load_sprites      ; zavolání subrutiny
000121r 1               
000121r 1                       ; načtení tabulky jmen
000121r 1  20 rr rr             jsr load_nametable    ; zavolání subrutiny
000124r 1               
000124r 1                       ; načtení atributů
000124r 1  20 rr rr             jsr load_attributes   ; zavolání subrutiny
000127r 1               
000127r 1  58                   cli                   ; vynulování bitu I - povolení přerušení
000128r 1  A9 90                lda #%10010000
00012Ar 1  8D 00 20             sta PPUCTRL           ; při každém VBLANK se vyvolá NMI (důležité!)
00012Dr 1               
00012Dr 1  A9 1E                lda #%00011110        ; povolení zobrazení pozadí a současně i spritů
00012Fr 1  8D 01 20             sta PPUMASK
000132r 1               
000132r 1  A9 0A                lda #10           ; inicializace čítačů
000134r 1  85 FE                sta COUNTER1
000136r 1  85 FF                sta COUNTER2
000138r 1               
000138r 1                       ; vlastní herní smyčka je prozatím prázdná
000138r 1               game_loop:
000138r 1  4C rr rr             jmp game_loop         ; nekonečná smyčka (později rozšíříme)
00013Br 1               .endproc
00013Br 1               
00013Br 1               
00013Br 1               
00013Br 1               ; vynulování barvové palety
00013Br 1               .proc clear_palette
00013Br 1  AD 02 20 A9          ppu_data_palette_address
00013Fr 1  3F 8D 06 20  
000143r 1  A9 00 8D 06  
000147r 1  20           
000148r 1               
000148r 1  A2 20                ldx #$20        ; počitadlo barev v paletě: 16+16
00014Ar 1  A9 00                lda #$00        ; vynulování každé barvy
00014Cr 1               
00014Cr 1               :
00014Cr 1  8D 07 20             sta PPUDATA     ; zápis barvy
00014Fr 1  CA                   dex             ; snížení hodnoty počitadla
000150r 1  D0 FA                bne :-
000152r 1               
000152r 1  60                   rts             ; návrat ze subrutiny
000153r 1               .endproc
000153r 1               
000153r 1               
000153r 1               
000153r 1               ; vynulování tabulek jmen
000153r 1               .proc clear_nametables
000153r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
000156r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
000158r 1  8D 06 20             sta PPUADDR
00015Br 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
00015Dr 1  8D 06 20             sta PPUADDR
000160r 1  A2 08                ldx #$08           ; počitadlo stránek (8)
000162r 1  A0 00                ldy #$00           ; X a Y tvoří 16bitový čítač
000164r 1  A9 24                lda #$24           ; dlaždice číslo $24 představuje oblohu
000166r 1               :
000166r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
000169r 1  88                   dey                ; snížení hodnoty počitadla
00016Ar 1  D0 FA                bne :-             ; skok dokud se nezaplní celá stránka
00016Cr 1  CA                   dex                ; snížení hodnoty počitadla stránek
00016Dr 1  D0 F7                bne :-             ; skok dokud se nezaplní 8 stránek
00016Fr 1               
00016Fr 1  60                   rts                ; návrat ze subrutiny
000170r 1               .endproc
000170r 1               
000170r 1               ; nastavení barvové palety
000170r 1               .proc load_palette
000170r 1  AD 02 20 A9          ppu_data_palette_address
000174r 1  3F 8D 06 20  
000178r 1  A9 00 8D 06  
00017Cr 1  20           
00017Dr 1               
00017Dr 1                       ; $3f00-$3f0f - paleta pozadí
00017Dr 1                       ; $3f10-$3f1f - paleta spritů
00017Dr 1               
00017Dr 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
00017Fr 1               
00017Fr 1               :
00017Fr 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
000182r 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
000185r 1  E8                   inx             ; zvýšit počitadlo/offset
000186r 1  E0 20                cpx #32         ; limit počtu barev
000188r 1  D0 F5                bne :-          ; opakovat smyčku 32x
00018Ar 1               
00018Ar 1  60                   rts             ; návrat ze subrutiny
00018Br 1               .endproc
00018Br 1               
00018Br 1               
00018Br 1               
00018Br 1               ; načtení spritů
00018Br 1               .proc load_sprites
00018Br 1  A2 00                ldx #0            ; vynulování počitadla
00018Dr 1               :
00018Dr 1  BD rr rr             lda spritedata,X  ; budeme přesouvat data z této oblasti
000190r 1  9D 00 02             sta $0200,X       ; uložení do paměti spritů
000193r 1  E8                   inx               ; zvýšení hodnoty počitadla
000194r 1  E0 20                cpx #32           ; každý sprite má 4 bajty: y-coord, tile, attributy, y-coord * 8 spritů = 32
000196r 1  D0 F5                bne :-
000198r 1               
000198r 1  60                   rts               ; návrat ze subrutiny
000199r 1               .endproc
000199r 1               
000199r 1               
000199r 1               
000199r 1               ; načtení tabulky jmen
000199r 1               .proc load_nametable
000199r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
00019Cr 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
00019Er 1  8D 06 20             sta PPUADDR
0001A1r 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
0001A3r 1  8D 06 20             sta PPUADDR
0001A6r 1               
0001A6r 1  A2 00                ldx #$00           ; počitadlo
0001A8r 1               :
0001A8r 1  BD rr rr             lda nametabledata,X
0001ABr 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0001AEr 1  E8                   inx
0001AFr 1  E0 80                cpx #$80           ; chceme přenést 128 bajtů
0001B1r 1  D0 F5                bne :-
0001B3r 1               
0001B3r 1  60                   rts                ; návrat ze subrutiny
0001B4r 1               .endproc
0001B4r 1               
0001B4r 1               
0001B4r 1               
0001B4r 1               ; načtení atributů
0001B4r 1               .proc load_attributes
0001B4r 1  AD 02 20             lda PPUSTATUS        ; reset záchytného registru
0001B7r 1  A9 23                lda #>ATTRIB_TABLE_0 ; horní bajt adresy $23c0
0001B9r 1  8D 06 20             sta PPUADDR
0001BCr 1  A9 C0                lda #<ATTRIB_TABLE_0 ; spodní bajt adresy $23c0
0001BEr 1  8D 06 20             sta PPUADDR
0001C1r 1  A2 00                ldx #$00             ; počitadlo smyčky
0001C3r 1               :
0001C3r 1  BD rr rr             lda attributedata,X
0001C6r 1  8D 07 20             sta PPUDATA          ; zápis indexu
0001C9r 1  E8                   inx                  ; zvýšení hodnoty počitadla
0001CAr 1  E0 08                cpx #$08             ; provádíme kopii osmi bajtů
0001CCr 1  D0 F5                bne :-
0001CEr 1               
0001CEr 1  60                   rts                  ; návrat ze subrutiny
0001CFr 1               .endproc
0001CFr 1               
0001CFr 1               
0001CFr 1               
0001CFr 1               ; samotná barvová paleta
0001CFr 1               palette:
0001CFr 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
0001D3r 1  22 36 17 0F  
0001D7r 1  22 30 21 0F  
0001DBr 1  22 27 17 0F  
0001DFr 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
0001E3r 1  22 1A 30 27  
0001E7r 1  22 16 30 27  
0001EBr 1  22 0F 36 17  
0001EFr 1               
0001EFr 1               
0001EFr 1               ; data pro osm spritů
0001EFr 1               spritedata:
0001EFr 1  10 00 00 08      .byte $10, $00, $00, $08   ; y-coord, tile number, attributes, x-coord
0001F3r 1  10 01 00 10      .byte $10, $01, $00, $10
0001F7r 1  18 02 00 08      .byte $18, $02, $00, $08
0001FBr 1  18 03 00 10      .byte $18, $03, $00, $10
0001FFr 1  20 04 00 08      .byte $20, $04, $00, $08
000203r 1  20 05 00 10      .byte $20, $05, $00, $10
000207r 1  28 06 00 08      .byte $28, $06, $00, $08
00020Br 1  28 07 00 10      .byte $28, $07, $00, $10
00020Fr 1               
00020Fr 1               
00020Fr 1               ; tabulka jmen
00020Fr 1               nametabledata:
00020Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; první řádek: nebe
000213r 1  24 24 24 24  
000217r 1  24 24 24 24  
00021Br 1  24 24 24 24  
00021Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000223r 1  24 24 24 24  
000227r 1  24 24 24 24  
00022Br 1  24 24 24 24  
00022Fr 1               
00022Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; druhý řádek: nebe
000233r 1  24 24 24 24  
000237r 1  24 24 24 24  
00023Br 1  24 24 24 24  
00023Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000243r 1  24 24 24 24  
000247r 1  24 24 24 24  
00024Br 1  24 24 24 24  
00024Fr 1               
00024Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$45,$45,$24,$24,$45,$45,$45,$45,$45,$45,$24,$24  ; třetí řádek
000253r 1  45 45 24 24  
000257r 1  45 45 45 45  
00025Br 1  45 45 24 24  
00025Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24  ; různé cihly (horní polovina)
000263r 1  24 24 24 24  
000267r 1  24 24 24 24  
00026Br 1  53 54 24 24  
00026Fr 1               
00026Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$47,$47,$24,$24,$47,$47,$47,$47,$47,$47,$24,$24  ; čtvrtý řádek
000273r 1  47 47 24 24  
000277r 1  47 47 47 47  
00027Br 1  47 47 24 24  
00027Fr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24  ; různé cihly (spodní polovina)
000283r 1  24 24 24 24  
000287r 1  24 24 24 24  
00028Br 1  55 56 24 24  
00028Fr 1               
00028Fr 1               
00028Fr 1               ; tabulka atributů
00028Fr 1               attributedata:
00028Fr 1  00 10 20 00      .byte %00000000, %00010000, %00100000, %00000000, %00000000, %00000000, %00000000, %00110000
000293r 1  00 00 00 30  
000297r 1               
000297r 1               
000297r 1               
000297r 1               ; ---------------------------------------------------------------------
000297r 1               ; Tabulka vektorů CPU
000297r 1               ; ---------------------------------------------------------------------
000297r 1               
000297r 1               .segment "VECTORS"
000000r 1  rr rr        .addr nmi
000002r 1  rr rr        .addr reset
000004r 1  rr rr        .addr irq
000006r 1               
000006r 1               
000006r 1               
000006r 1               .segment "CHARS"
000000r 1  03 0F 1F 1F      .incbin "mario.chr"
000004r 1  1C 24 26 66  
000008r 1  00 00 00 00  
00000Cr 1  1F 3F 3F 7F  
000010r 1  E0 C0 80 FC  
000014r 1  80 C0 00 20  
000018r 1  00 20 60 00  
00001Cr 1  F0 FC FE FE  
000020r 1  60 70 18 07  
000024r 1  0F 1F 3F 7F  
000028r 1  7F 7F 1F 07  
00002Cr 1  00 1E 3F 7F  
000030r 1  FC 7C 00 00  
000034r 1  E0 F0 F8 F8  
000038r 1  FC FC F8 C0  
00003Cr 1  C2 67 2F 37  
000040r 1  7F 7F FF FF  
000044r 1  07 07 0F 0F  
000048r 1  7F 7E FC F0  
00004Cr 1  F8 F8 F0 70  
000050r 1  FD FE B4 F8  
000054r 1  F8 F9 FB FF  
000058r 1  37 36 5C 00  
00005Cr 1  00 01 03 1F  
000060r 1  1F 3F FF FF  
002000r 1               
002000r 1               
002000r 1               
002000r 1               ; ---------------------------------------------------------------------
002000r 1               ; Finito
002000r 1               ; ---------------------------------------------------------------------
002000r 1               
