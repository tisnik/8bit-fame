ca65 V2.18 - Ubuntu 2.18-1
Main file   : example21.asm
Current file: example21.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity barvy
000000r 1               ; Setup PPU přes makro
000000r 1               ; Definice spritu a zobrazení spritů s rozloženým Mariem.
000000r 1               ; Pohyb celého Maria.
000000r 1               ; Využití symbolických jmen adres.
000000r 1               ; Pomocná makra pro pohyb spritu.
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
000000r 1               
000000r 1               ; Ovladače
000000r 1               JOYPAD1         = $4016
000000r 1               JOYPAD2         = $4017
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
00000Fr 1  AD 16 40 29          read_button        ; stav tlačítka A jen načteme a ingorujeme
000013r 1  01           
000014r 1  AD 16 40 29          read_button        ; stav tlačítka B jen načteme a ingorujeme
000018r 1  01           
000019r 1  AD 16 40 29          read_button        ; stav tlačítka Select jen načteme a ingorujeme
00001Dr 1  01           
00001Er 1  AD 16 40 29          read_button        ; stav tlačítka Start jen načteme a ingorujeme
000022r 1  01           
000023r 1               
000023r 1                       XPOS = $0203       ; adresa buňky paměti s x-ovou souřadnicí spritu
000023r 1                       YPOS = $0200       ; adresa buňky paměti y x-ovou souřadnicí spritu
000023r 1               
000023r 1  AD 16 40 29          read_button        ; stav tlačítka Up
000027r 1  01           
000028r 1  F0 0E                beq up_not_pressed ; není stisknuto? => skok
00002Ar 1               
00002Ar 1  A2 00 DE 00          decrement_block YPOS, 8, 4
00002Er 1  02 8A 18 69  
000032r 1  04 AA C9 20  
000036r 1  D0 F4        
000038r 1               
000038r 1               up_not_pressed:
000038r 1               
000038r 1  AD 16 40 29          read_button        ; stav tlačítka Down
00003Cr 1  01           
00003Dr 1  F0 0E                beq down_not_pressed ; není stisknuto? => skok
00003Fr 1               
00003Fr 1  A2 00 FE 00          increment_block YPOS, 8, 4
000043r 1  02 8A 18 69  
000047r 1  04 AA C9 20  
00004Br 1  D0 F4        
00004Dr 1               
00004Dr 1               down_not_pressed:
00004Dr 1               
00004Dr 1  AD 16 40 29          read_button      ; stav tlačítka Left
000051r 1  01           
000052r 1  F0 0E                beq left_not_pressed ; není stisknuto? => skok
000054r 1               
000054r 1  A2 00 DE 03          decrement_block XPOS, 8, 4
000058r 1  02 8A 18 69  
00005Cr 1  04 AA C9 20  
000060r 1  D0 F4        
000062r 1               
000062r 1               left_not_pressed:
000062r 1               
000062r 1  AD 16 40 29          read_button      ; stav tlačítka Right
000066r 1  01           
000067r 1  F0 0E                beq right_not_pressed ; není stisknuto? => skok
000069r 1               
000069r 1  A2 00 FE 03          increment_block XPOS, 8, 4
00006Dr 1  02 8A 18 69  
000071r 1  04 AA C9 20  
000075r 1  D0 F4        
000077r 1               
000077r 1               right_not_pressed:
000077r 1               
000077r 1  40                   rti                ; návrat z přerušení
000078r 1               
000078r 1               .endproc
000078r 1               
000078r 1               
000078r 1               
000078r 1               ; Obslužná rutina pro IRQ (maskovatelné přerušení)
000078r 1               
000078r 1               .proc irq
000078r 1  40                   rti                     ; návrat z přerušení
000079r 1               .endproc
000079r 1               
000079r 1               
000079r 1               
000079r 1               ; Obslužná rutina pro RESET
000079r 1               
000079r 1               .proc reset
000079r 1                       ; nastavení stavu CPU
000079r 1  78 D8 A2 FF          setup_cpu
00007Dr 1  9A           
00007Er 1               
00007Er 1                       ; nastavení řídicích registrů
00007Er 1  A2 00                ldx #$00
000080r 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
000083r 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
000086r 1  8E 10 40             stx DMC_FREQ            ; zákaz DMC IRQ
000089r 1               
000089r 1  A2 40                ldx #$40
00008Br 1  8E 17 40             stx $4017               ; interrupt inhibit bit
00008Er 1               
00008Er 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
00008Er 1  2C 02 20 10          wait_for_frame
000092r 1  FB           
000093r 1  2C 02 20 10          wait_for_frame
000097r 1  FB           
000098r 1               
000098r 1                       ; vymazání obsahu RAM
000098r 1  A9 00 95 00          clear_ram
00009Cr 1  9D 00 01 9D  
0000A0r 1  00 02 9D 00  
0000A4r 1  03 9D 00 04  
0000A8r 1  9D 00 05 9D  
0000ACr 1  00 06 9D 00  
0000B0r 1  07 E8 D0 E6  
0000B4r 1               
0000B4r 1                       ; čekání na další snímek
0000B4r 1  2C 02 20 10          wait_for_frame
0000B8r 1  FB           
0000B9r 1               
0000B9r 1                       ; nastavení barvové palety
0000B9r 1  20 rr rr             jsr load_palette  ; zavolání subrutiny
0000BCr 1               
0000BCr 1                       ; nastavení spritů
0000BCr 1  20 rr rr             jsr load_sprites  ; zavolání subrutiny
0000BFr 1               
0000BFr 1                       ; vlastní herní smyčka je prozatím prázdná
0000BFr 1               game_loop:
0000BFr 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
0000C2r 1               .endproc
0000C2r 1               
0000C2r 1               
0000C2r 1               
0000C2r 1               ; vynulování barvové palety
0000C2r 1               .proc clear_palette
0000C2r 1  AD 02 20 A9          ppu_data_palette_address
0000C6r 1  3F 8D 06 20  
0000CAr 1  A9 00 8D 06  
0000CEr 1  20           
0000CFr 1               
0000CFr 1  A2 20                ldx #$20        ; počitadlo barev v paletě: 16+16
0000D1r 1  A9 00                lda #$00        ; vynulování každé barvy
0000D3r 1               
0000D3r 1               :
0000D3r 1  8D 07 20             sta PPUDATA     ; zápis barvy
0000D6r 1  CA                   dex             ; snížení hodnoty počitadla
0000D7r 1  D0 FA                bne :-
0000D9r 1               
0000D9r 1  60                   rts             ; návrat ze subrutiny
0000DAr 1               .endproc
0000DAr 1               
0000DAr 1               
0000DAr 1               
0000DAr 1               ; nastavení barvové palety
0000DAr 1               .proc load_palette
0000DAr 1  AD 02 20 A9          ppu_data_palette_address
0000DEr 1  3F 8D 06 20  
0000E2r 1  A9 00 8D 06  
0000E6r 1  20           
0000E7r 1               
0000E7r 1                       ; $3f00-$3f0f - paleta pozadí
0000E7r 1                       ; $3f10-$3f1f - paleta spritů
0000E7r 1               
0000E7r 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
0000E9r 1               
0000E9r 1               :
0000E9r 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
0000ECr 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
0000EFr 1  E8                   inx             ; zvýšit počitadlo/offset
0000F0r 1  E0 20                cpx #32         ; limit počtu barev
0000F2r 1  D0 F5                bne :-          ; opakovat smyčku 32x
0000F4r 1               
0000F4r 1  60                   rts             ; návrat ze subrutiny
0000F5r 1               .endproc
0000F5r 1               
0000F5r 1               
0000F5r 1               
0000F5r 1               ; načtení spritů
0000F5r 1               .proc load_sprites
0000F5r 1  A2 00                ldx #0
0000F7r 1               :
0000F7r 1  BD rr rr             lda spritedata,X  ; budeme přesouvat data z této oblasti
0000FAr 1  9D 00 02             sta $0200,X       ; uložení do paměti spritů
0000FDr 1  E8                   inx               ; zvýšení hodnoty počitadla
0000FEr 1  E0 20                cpx #32           ; každý sprite má 4 bajty: y-coord, tile, attributy, y-coord * 8 spritů = 32
000100r 1  D0 F5                bne :-
000102r 1               
000102r 1  58                   cli               ; vynulování bitu I - povolení přerušení
000103r 1  A9 80                lda #%10000000
000105r 1  8D 00 20             sta PPUCTRL       ; při každém VBLANK se vyvolá NMI (důležité!)
000108r 1               
000108r 1  A9 10                lda #%00010000    ; povolení zobrazení spritů
00010Ar 1  8D 01 20             sta PPUMASK
00010Dr 1               
00010Dr 1  60                   rts               ; návrat ze subrutiny
00010Er 1               .endproc
00010Er 1               
00010Er 1               
00010Er 1               
00010Er 1               ; samotná barvová paleta
00010Er 1               palette:
00010Er 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
000112r 1  22 36 17 0F  
000116r 1  22 30 21 0F  
00011Ar 1  22 27 17 0F  
00011Er 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
000122r 1  22 1A 30 27  
000126r 1  22 16 30 27  
00012Ar 1  22 0F 36 17  
00012Er 1               
00012Er 1               ; data pro větší množství spritů
00012Er 1               spritedata:
00012Er 1  10 00 00 08      .byte $10, $00, $00, $08   ; y-coord, tile number, attributes, x-coord
000132r 1  10 01 00 10      .byte $10, $01, $00, $10
000136r 1  18 02 00 08      .byte $18, $02, $00, $08
00013Ar 1  18 03 00 10      .byte $18, $03, $00, $10
00013Er 1  20 04 00 08      .byte $20, $04, $00, $08
000142r 1  20 05 00 10      .byte $20, $05, $00, $10
000146r 1  28 06 00 08      .byte $28, $06, $00, $08
00014Ar 1  28 07 00 10      .byte $28, $07, $00, $10
00014Er 1               
00014Er 1               
00014Er 1               
00014Er 1               ; ---------------------------------------------------------------------
00014Er 1               ; Tabulka vektorů CPU
00014Er 1               ; ---------------------------------------------------------------------
00014Er 1               
00014Er 1               .segment "VECTORS"
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
