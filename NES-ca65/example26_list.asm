ca65 V2.18 - Ubuntu 2.18-1
Main file   : example26.asm
Current file: example26.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity barvy
000000r 1               ; Setup PPU přes makro
000000r 1               ; Definice spritu a zobrazení spritů s Mariem
000000r 1               ; Definice pozadí a zobrazení pozadí
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
000005r 1  40                   rti               ; návrat z přerušení
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
00000Cr 1  A2 40                ldx #$40
00000Er 1  8E 17 40             stx $4017               ; zákaz IRQ z APU
000011r 1               
000011r 1  A2 00                ldx #$00
000013r 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
000016r 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
000019r 1  8E 10 40             stx DMC_FREQ            ; zákaz DMC IRQ
00001Cr 1               
00001Cr 1  A2 40                ldx #$40
00001Er 1  8E 17 40             stx $4017               ; interrupt inhibit bit
000021r 1               
000021r 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
000021r 1  2C 02 20 10          wait_for_frame
000025r 1  FB           
000026r 1  2C 02 20 10          wait_for_frame
00002Ar 1  FB           
00002Br 1               
00002Br 1                       ; vymazání obsahu RAM
00002Br 1  A9 00 95 00          clear_ram
00002Fr 1  9D 00 01 9D  
000033r 1  00 02 9D 00  
000037r 1  03 9D 00 04  
00003Br 1  9D 00 05 9D  
00003Fr 1  00 06 9D 00  
000043r 1  07 E8 D0 E6  
000047r 1               
000047r 1                       ; čekání na další snímek
000047r 1  2C 02 20 10          wait_for_frame
00004Br 1  FB           
00004Cr 1               
00004Cr 1                       ; nastavení tabulek jmen
00004Cr 1  20 rr rr             jsr clear_nametables  ; zavolání subrutiny
00004Fr 1               
00004Fr 1                       ; nastavení barvové palety
00004Fr 1  20 rr rr             jsr load_palette      ; zavolání subrutiny
000052r 1               
000052r 1                       ; nastavení spritů
000052r 1  20 rr rr             jsr load_sprites      ; zavolání subrutiny
000055r 1               
000055r 1                       ; načtení tabulky jmen
000055r 1  20 rr rr             jsr load_nametable    ; zavolání subrutiny
000058r 1               
000058r 1                       ; načtení atributů
000058r 1  20 rr rr             jsr load_attributes   ; zavolání subrutiny
00005Br 1               
00005Br 1  58                   cli                   ; vynulování bitu I - povolení přerušení
00005Cr 1  A9 90                lda #%10010000
00005Er 1  8D 00 20             sta PPUCTRL           ; při každém VBLANK se vyvolá NMI (důležité!)
000061r 1               
000061r 1  A9 1E                lda #%00011110        ; povolení zobrazení pozadí a současně i spritů
000063r 1  8D 01 20             sta PPUMASK
000066r 1               
000066r 1                       ; vlastní herní smyčka je prozatím prázdná
000066r 1               game_loop:
000066r 1  4C rr rr             jmp game_loop         ; nekonečná smyčka (později rozšíříme)
000069r 1               .endproc
000069r 1               
000069r 1               
000069r 1               
000069r 1               ; vynulování barvové palety
000069r 1               .proc clear_palette
000069r 1  AD 02 20 A9          ppu_data_palette_address
00006Dr 1  3F 8D 06 20  
000071r 1  A9 00 8D 06  
000075r 1  20           
000076r 1               
000076r 1  A2 20                ldx #$20        ; počitadlo barev v paletě: 16+16
000078r 1  A9 00                lda #$00        ; vynulování každé barvy
00007Ar 1               
00007Ar 1               :
00007Ar 1  8D 07 20             sta PPUDATA     ; zápis barvy
00007Dr 1  CA                   dex             ; snížení hodnoty počitadla
00007Er 1  D0 FA                bne :-
000080r 1               
000080r 1  60                   rts             ; návrat ze subrutiny
000081r 1               .endproc
000081r 1               
000081r 1               
000081r 1               
000081r 1               ; vynulování tabulek jmen
000081r 1               .proc clear_nametables
000081r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
000084r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
000086r 1  8D 06 20             sta PPUADDR
000089r 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
00008Br 1  8D 06 20             sta PPUADDR
00008Er 1  A2 08                ldx #$08           ; počitadlo stránek (8)
000090r 1  A0 00                ldy #$00           ; X a Y tvoří 16bitový čítač
000092r 1  A9 24                lda #$24           ; dlaždice číslo $24 představuje oblohu
000094r 1               :
000094r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
000097r 1  88                   dey                ; snížení hodnoty počitadla
000098r 1  D0 FA                bne :-             ; skok dokud se nezaplní celá stránka
00009Ar 1  CA                   dex                ; snížení hodnoty počitadla stránek
00009Br 1  D0 F7                bne :-             ; skok dokud se nezaplní 8 stránek
00009Dr 1               
00009Dr 1  60                   rts                ; návrat ze subrutiny
00009Er 1               .endproc
00009Er 1               
00009Er 1               ; nastavení barvové palety
00009Er 1               .proc load_palette
00009Er 1  AD 02 20 A9          ppu_data_palette_address
0000A2r 1  3F 8D 06 20  
0000A6r 1  A9 00 8D 06  
0000AAr 1  20           
0000ABr 1               
0000ABr 1                       ; $3f00-$3f0f - paleta pozadí
0000ABr 1                       ; $3f10-$3f1f - paleta spritů
0000ABr 1               
0000ABr 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
0000ADr 1               
0000ADr 1               :
0000ADr 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
0000B0r 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
0000B3r 1  E8                   inx             ; zvýšit počitadlo/offset
0000B4r 1  E0 20                cpx #32         ; limit počtu barev
0000B6r 1  D0 F5                bne :-          ; opakovat smyčku 32x
0000B8r 1               
0000B8r 1  60                   rts             ; návrat ze subrutiny
0000B9r 1               .endproc
0000B9r 1               
0000B9r 1               
0000B9r 1               
0000B9r 1               ; načtení spritů
0000B9r 1               .proc load_sprites
0000B9r 1  A2 00                ldx #0            ; vynulování počitadla
0000BBr 1               :
0000BBr 1  BD rr rr             lda spritedata,X  ; budeme přesouvat data z této oblasti
0000BEr 1  9D 00 02             sta $0200,X       ; uložení do paměti spritů
0000C1r 1  E8                   inx               ; zvýšení hodnoty počitadla
0000C2r 1  E0 20                cpx #32           ; každý sprite má 4 bajty: y-coord, tile, attributy, y-coord * 8 spritů = 32
0000C4r 1  D0 F5                bne :-
0000C6r 1               
0000C6r 1  60                   rts               ; návrat ze subrutiny
0000C7r 1               .endproc
0000C7r 1               
0000C7r 1               
0000C7r 1               
0000C7r 1               ; načtení tabulky jmen
0000C7r 1               .proc load_nametable
0000C7r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
0000CAr 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
0000CCr 1  8D 06 20             sta PPUADDR
0000CFr 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
0000D1r 1  8D 06 20             sta PPUADDR
0000D4r 1               
0000D4r 1  A2 00                ldx #$00           ; počitadlo
0000D6r 1               :
0000D6r 1  BD rr rr             lda nametabledata,X
0000D9r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0000DCr 1  E8                   inx
0000DDr 1  E0 80                cpx #$80           ; chceme přenést 128 bajtů
0000DFr 1  D0 F5                bne :-
0000E1r 1               
0000E1r 1  60                   rts                ; návrat ze subrutiny
0000E2r 1               .endproc
0000E2r 1               
0000E2r 1               
0000E2r 1               
0000E2r 1               ; načtení atributů
0000E2r 1               .proc load_attributes
0000E2r 1  AD 02 20             lda PPUSTATUS        ; reset záchytného registru
0000E5r 1  A9 23                lda #>ATTRIB_TABLE_0 ; horní bajt adresy $23c0
0000E7r 1  8D 06 20             sta PPUADDR
0000EAr 1  A9 C0                lda #<ATTRIB_TABLE_0 ; spodní bajt adresy $23c0
0000ECr 1  8D 06 20             sta PPUADDR
0000EFr 1  A2 00                ldx #$00             ; počitadlo smyčky
0000F1r 1               :
0000F1r 1  BD rr rr             lda attributedata,X
0000F4r 1  8D 07 20             sta PPUDATA          ; zápis indexu
0000F7r 1  E8                   inx                  ; zvýšení hodnoty počitadla
0000F8r 1  E0 08                cpx #$08             ; provádíme kopii osmi bajtů
0000FAr 1  D0 F5                bne :-
0000FCr 1               
0000FCr 1  60                   rts                  ; návrat ze subrutiny
0000FDr 1               .endproc
0000FDr 1               
0000FDr 1               
0000FDr 1               
0000FDr 1               ; samotná barvová paleta
0000FDr 1               palette:
0000FDr 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
000101r 1  22 36 17 0F  
000105r 1  22 30 21 0F  
000109r 1  22 27 17 0F  
00010Dr 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
000111r 1  22 1A 30 27  
000115r 1  22 16 30 27  
000119r 1  22 0F 36 17  
00011Dr 1               
00011Dr 1               
00011Dr 1               ; data pro osm spritů
00011Dr 1               spritedata:
00011Dr 1  10 00 00 08      .byte $10, $00, $00, $08   ; y-coord, tile number, attributes, x-coord
000121r 1  10 01 00 10      .byte $10, $01, $00, $10
000125r 1  18 02 00 08      .byte $18, $02, $00, $08
000129r 1  18 03 00 10      .byte $18, $03, $00, $10
00012Dr 1  20 04 00 08      .byte $20, $04, $00, $08
000131r 1  20 05 00 10      .byte $20, $05, $00, $10
000135r 1  28 06 00 08      .byte $28, $06, $00, $08
000139r 1  28 07 00 10      .byte $28, $07, $00, $10
00013Dr 1               
00013Dr 1               
00013Dr 1               ; tabulka jmen
00013Dr 1               nametabledata:
00013Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; první řádek: nebe
000141r 1  24 24 24 24  
000145r 1  24 24 24 24  
000149r 1  24 24 24 24  
00014Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000151r 1  24 24 24 24  
000155r 1  24 24 24 24  
000159r 1  24 24 24 24  
00015Dr 1               
00015Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; druhý řádek: nebe
000161r 1  24 24 24 24  
000165r 1  24 24 24 24  
000169r 1  24 24 24 24  
00016Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000171r 1  24 24 24 24  
000175r 1  24 24 24 24  
000179r 1  24 24 24 24  
00017Dr 1               
00017Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$45,$45,$24,$24,$45,$45,$45,$45,$45,$45,$24,$24  ; třetí řádek
000181r 1  45 45 24 24  
000185r 1  45 45 45 45  
000189r 1  45 45 24 24  
00018Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24  ; různé cihly (horní polovina)
000191r 1  24 24 24 24  
000195r 1  24 24 24 24  
000199r 1  53 54 24 24  
00019Dr 1               
00019Dr 1  24 24 24 24      .byte $24,$24,$24,$24,$47,$47,$24,$24,$47,$47,$47,$47,$47,$47,$24,$24  ; čtvrtý řádek
0001A1r 1  47 47 24 24  
0001A5r 1  47 47 47 47  
0001A9r 1  47 47 24 24  
0001ADr 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24  ; různé cihly (spodní polovina)
0001B1r 1  24 24 24 24  
0001B5r 1  24 24 24 24  
0001B9r 1  55 56 24 24  
0001BDr 1               
0001BDr 1               
0001BDr 1               ; tabulka atributů
0001BDr 1               attributedata:
0001BDr 1  00 10 20 00      .byte %00000000, %00010000, %00100000, %00000000, %00000000, %00000000, %00000000, %00110000
0001C1r 1  00 00 00 30  
0001C5r 1               
0001C5r 1               
0001C5r 1               
0001C5r 1               ; ---------------------------------------------------------------------
0001C5r 1               ; Tabulka vektorů CPU
0001C5r 1               ; ---------------------------------------------------------------------
0001C5r 1               
0001C5r 1               .segment "VECTORS"
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
