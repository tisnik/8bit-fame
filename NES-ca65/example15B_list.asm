ca65 V2.18 - Ubuntu 2.18-1
Main file   : example15B.asm
Current file: example15B.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity barvy
000000r 1               ; Setup PPU přes makro
000000r 1               ; Definice spritu a zobrazení spritů s rozloženým Mariem. Současné
000000r 1               ; zobrazení většího množství spritů.
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
000000r 1  A9 02                lda #$02          ; horní bajt adresy pro přenos + zahájení přenosu
000002r 1  8D 14 40             sta OAM_DMA
000005r 1  40                   rti                     ; návrat z přerušení
000006r 1               .endproc
000006r 1               
000006r 1               
000006r 1               
000006r 1               ; Obslužná rutina pro IRQ (maskovatelné přerušení)
000006r 1               
000006r 1               .proc irq
000006r 1  40                   rti                     ; návrat z přerušení
000007r 1               .endproc
000007r 1               
000007r 1               
000007r 1               
000007r 1               ; Obslužná rutina pro RESET
000007r 1               
000007r 1               .proc reset
000007r 1                       ; nastavení stavu CPU
000007r 1  78 D8 A2 FF          setup_cpu
00000Br 1  9A           
00000Cr 1               
00000Cr 1                       ; nastavení řídicích registrů
00000Cr 1  A2 00                ldx #$00
00000Er 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
000011r 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
000014r 1  8E 10 40             stx DMC_FREQ            ; zákaz DMC IRQ
000017r 1               
000017r 1  A2 40                ldx #$40
000019r 1  8E 17 40             stx $4017               ; interrupt inhibit bit
00001Cr 1               
00001Cr 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
00001Cr 1  2C 02 20 10          wait_for_frame
000020r 1  FB           
000021r 1  2C 02 20 10          wait_for_frame
000025r 1  FB           
000026r 1               
000026r 1                       ; vymazání obsahu RAM
000026r 1  A9 00 95 00          clear_ram
00002Ar 1  9D 00 01 9D  
00002Er 1  00 02 9D 00  
000032r 1  03 9D 00 04  
000036r 1  9D 00 05 9D  
00003Ar 1  00 06 9D 00  
00003Er 1  07 E8 D0 E6  
000042r 1               
000042r 1                       ; čekání na další snímek
000042r 1  2C 02 20 10          wait_for_frame
000046r 1  FB           
000047r 1               
000047r 1                       ; nastavení barvové palety
000047r 1  20 rr rr             jsr load_palette  ; zavolání subrutiny
00004Ar 1               
00004Ar 1                       ; nastavení spritů
00004Ar 1  20 rr rr             jsr load_sprites  ; zavolání subrutiny
00004Dr 1               
00004Dr 1                       ; vlastní herní smyčka je prozatím prázdná
00004Dr 1               game_loop:
00004Dr 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
000050r 1               .endproc
000050r 1               
000050r 1               
000050r 1               
000050r 1               ; vynulování barvové palety
000050r 1               .proc clear_palette
000050r 1  AD 02 20 A9          ppu_data_palette_address
000054r 1  3F 8D 06 20  
000058r 1  A9 00 8D 06  
00005Cr 1  20           
00005Dr 1               
00005Dr 1  A2 20                ldx #$20        ; počitadlo barev v paletě: 16+16
00005Fr 1  A9 00                lda #$00        ; vynulování každé barvy
000061r 1               
000061r 1               :
000061r 1  8D 07 20             sta PPUDATA     ; zápis barvy
000064r 1  CA                   dex             ; snížení hodnoty počitadla
000065r 1  D0 FA                bne :-
000067r 1               
000067r 1  60                   rts             ; návrat ze subrutiny
000068r 1               .endproc
000068r 1               
000068r 1               
000068r 1               
000068r 1               ; nastavení barvové palety
000068r 1               .proc load_palette
000068r 1  AD 02 20 A9          ppu_data_palette_address
00006Cr 1  3F 8D 06 20  
000070r 1  A9 00 8D 06  
000074r 1  20           
000075r 1               
000075r 1                       ; $3f00-$3f0f - paleta pozadí
000075r 1                       ; $3f10-$3f1f - paleta spritů
000075r 1               
000075r 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
000077r 1               
000077r 1               :
000077r 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
00007Ar 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
00007Dr 1  E8                   inx             ; zvýšit počitadlo/offset
00007Er 1  E0 20                cpx #32         ; limit počtu barev
000080r 1  D0 F5                bne :-          ; opakovat smyčku 32x
000082r 1               
000082r 1  60                   rts             ; návrat ze subrutiny
000083r 1               .endproc
000083r 1               
000083r 1               
000083r 1               
000083r 1               ; načtení spritů
000083r 1               .proc load_sprites
000083r 1  A2 00                ldx #0
000085r 1               :
000085r 1  BD rr rr             lda spritedata,X  ; budeme přesouvat data z této oblasti
000088r 1  9D 00 02             sta $0200,X       ; uložení do paměti spritů
00008Br 1  E8                   inx               ; zvýšení hodnoty počitadla
00008Cr 1  E0 A0                cpx #160          ; každý sprite má 4 bajty: y-coord, tile, attributy, y-coord * 8 spritů = 32
00008Er 1               	                  ; * 4 postavičky = 128
00008Er 1  D0 F5                bne :-
000090r 1               
000090r 1  58                   cli               ; vynulování bitu I - povolení přerušení
000091r 1  A9 80                lda #%10000000
000093r 1  8D 00 20             sta PPUCTRL       ; při každém VBLANK se vyvolá NMI (důležité!)
000096r 1               
000096r 1  A9 10                lda #%00010000    ; povolení zobrazení spritů
000098r 1  8D 01 20             sta PPUMASK
00009Br 1               
00009Br 1  60                   rts               ; návrat ze subrutiny
00009Cr 1               .endproc
00009Cr 1               
00009Cr 1               
00009Cr 1               
00009Cr 1               ; samotná barvová paleta
00009Cr 1               palette:
00009Cr 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
0000A0r 1  22 36 17 0F  
0000A4r 1  22 30 21 0F  
0000A8r 1  22 27 17 0F  
0000ACr 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
0000B0r 1  22 1A 30 27  
0000B4r 1  22 16 30 27  
0000B8r 1  22 0F 36 17  
0000BCr 1               
0000BCr 1               ; data pro větší množství spritů
0000BCr 1               spritedata:
0000BCr 1  10 00 00 08      .byte $10, $00, $00, $08   ; y-coord, tile number, attributes, x-coord
0000C0r 1  10 01 00 10      .byte $10, $01, $00, $10
0000C4r 1  18 02 00 08      .byte $18, $02, $00, $08
0000C8r 1  18 03 00 10      .byte $18, $03, $00, $10
0000CCr 1  20 04 00 08      .byte $20, $04, $00, $08
0000D0r 1  20 05 00 10      .byte $20, $05, $00, $10
0000D4r 1  28 06 00 08      .byte $28, $06, $00, $08
0000D8r 1  28 07 00 10      .byte $28, $07, $00, $10
0000DCr 1               
0000DCr 1  30 08 00 18      .byte $30, $08, $00, $18   ; y-coord, tile number, attributes, x-coord
0000E0r 1  30 09 00 20      .byte $30, $09, $00, $20
0000E4r 1  38 0A 00 18      .byte $38, $0a, $00, $18
0000E8r 1  38 0B 00 20      .byte $38, $0b, $00, $20
0000ECr 1  40 0C 00 18      .byte $40, $0c, $00, $18
0000F0r 1  40 0D 00 20      .byte $40, $0d, $00, $20
0000F4r 1  48 0D 00 18      .byte $48, $0d, $00, $18
0000F8r 1  48 0F 00 20      .byte $48, $0f, $00, $20
0000FCr 1               
0000FCr 1  50 10 00 28      .byte $50, $10, $00, $28   ; y-coord, tile number, attributes, x-coord
000100r 1  50 11 00 30      .byte $50, $11, $00, $30
000104r 1  58 12 00 28      .byte $58, $12, $00, $28
000108r 1  58 13 00 30      .byte $58, $13, $00, $30
00010Cr 1  60 14 00 28      .byte $60, $14, $00, $28
000110r 1  60 15 00 30      .byte $60, $15, $00, $30
000114r 1  68 16 00 28      .byte $68, $16, $00, $28
000118r 1  68 17 00 30      .byte $68, $17, $00, $30
00011Cr 1               
00011Cr 1  70 18 00 38      .byte $70, $18, $00, $38   ; y-coord, tile number, attributes, x-coord
000120r 1  70 19 00 40      .byte $70, $19, $00, $40
000124r 1  78 1A 00 38      .byte $78, $1a, $00, $38
000128r 1  78 1B 00 40      .byte $78, $1b, $00, $40
00012Cr 1  80 1C 00 38      .byte $80, $1c, $00, $38
000130r 1  80 1D 00 40      .byte $80, $1d, $00, $40
000134r 1  88 1D 00 38      .byte $88, $1d, $00, $38
000138r 1  88 1F 00 40      .byte $88, $1f, $00, $40
00013Cr 1               
00013Cr 1  90 20 00 48      .byte $90, $20, $00, $48   ; y-coord, tile number, attributes, x-coord
000140r 1  90 21 00 50      .byte $90, $21, $00, $50
000144r 1  98 22 00 48      .byte $98, $22, $00, $48
000148r 1  98 23 00 50      .byte $98, $23, $00, $50
00014Cr 1  A0 24 00 48      .byte $a0, $24, $00, $48
000150r 1  A0 25 00 50      .byte $a0, $25, $00, $50
000154r 1  A8 26 00 48      .byte $a8, $26, $00, $48
000158r 1  A8 27 00 50      .byte $a8, $27, $00, $50
00015Cr 1               
00015Cr 1               
00015Cr 1               
00015Cr 1               ; ---------------------------------------------------------------------
00015Cr 1               ; Tabulka vektorů CPU
00015Cr 1               ; ---------------------------------------------------------------------
00015Cr 1               
00015Cr 1               .segment "VECTORS"
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
