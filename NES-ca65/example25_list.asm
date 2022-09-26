ca65 V2.18 - Ubuntu 2.18-1
Main file   : example25.asm
Current file: example25.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity barvy
000000r 1               ; Setup PPU přes makro
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
000052r 1                       ; načtení tabulky jmen
000052r 1  20 rr rr             jsr load_nametable    ; zavolání subrutiny
000055r 1               
000055r 1                       ; načtení atributů
000055r 1  20 rr rr             jsr load_attributes   ; zavolání subrutiny
000058r 1               
000058r 1  58                   cli                   ; vynulování bitu I - povolení přerušení
000059r 1  A9 90                lda #%10010000
00005Br 1  8D 00 20             sta PPUCTRL           ; při každém VBLANK se vyvolá NMI (důležité!)
00005Er 1               
00005Er 1  A9 0E                lda #%00001110        ; povolení zobrazení pozadí, nikoli ovšem spritů
000060r 1  8D 01 20             sta PPUMASK
000063r 1               
000063r 1                       ; vlastní herní smyčka je prozatím prázdná
000063r 1               game_loop:
000063r 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
000066r 1               .endproc
000066r 1               
000066r 1               
000066r 1               
000066r 1               ; vynulování tabulek jmen
000066r 1               .proc clear_nametables
000066r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
000069r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
00006Br 1  8D 06 20             sta PPUADDR
00006Er 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
000070r 1  8D 06 20             sta PPUADDR
000073r 1  A2 08                ldx #$08           ; počitadlo stránek (8)
000075r 1  A0 00                ldy #$00           ; X a Y tvoří 16bitový čítač
000077r 1  A9 24                lda #$24           ; dlaždice číslo $24 představuje oblohu
000079r 1               :
000079r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
00007Cr 1  88                   dey                ; snížení hodnoty počitadla
00007Dr 1  D0 FA                bne :-             ; skok dokud se nezaplní celá stránka
00007Fr 1  CA                   dex                ; snížení hodnoty počitadla stránek
000080r 1  D0 F7                bne :-             ; skok dokud se nezaplní 8 stránek
000082r 1               
000082r 1  60                   rts                ; návrat ze subrutiny
000083r 1               .endproc
000083r 1               
000083r 1               ; nastavení barvové palety
000083r 1               .proc load_palette
000083r 1  AD 02 20 A9          ppu_data_palette_address
000087r 1  3F 8D 06 20  
00008Br 1  A9 00 8D 06  
00008Fr 1  20           
000090r 1               
000090r 1                       ; $3f00-$3f0f - paleta pozadí
000090r 1                       ; $3f10-$3f1f - paleta spritů
000090r 1               
000090r 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
000092r 1               
000092r 1               :
000092r 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
000095r 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
000098r 1  E8                   inx             ; zvýšit počitadlo/offset
000099r 1  E0 20                cpx #32         ; limit počtu barev
00009Br 1  D0 F5                bne :-          ; opakovat smyčku 32x
00009Dr 1               
00009Dr 1  60                   rts             ; návrat ze subrutiny
00009Er 1               .endproc
00009Er 1               
00009Er 1               
00009Er 1               
00009Er 1               ; načtení tabulky jmen
00009Er 1               .proc load_nametable
00009Er 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
0000A1r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
0000A3r 1  8D 06 20             sta PPUADDR
0000A6r 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
0000A8r 1  8D 06 20             sta PPUADDR
0000ABr 1               
0000ABr 1  A2 00                ldx #$00           ; počitadlo
0000ADr 1               :
0000ADr 1  BD rr rr             lda nametabledata,X
0000B0r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0000B3r 1  E8                   inx
0000B4r 1  E0 80                cpx #$80           ; chceme přenést 128 bajtů
0000B6r 1  D0 F5                bne :-
0000B8r 1               
0000B8r 1  60                   rts                ; návrat ze subrutiny
0000B9r 1               .endproc
0000B9r 1               
0000B9r 1               
0000B9r 1               
0000B9r 1               ; načtení atributů
0000B9r 1               .proc load_attributes
0000B9r 1  AD 02 20             lda PPUSTATUS        ; reset záchytného registru
0000BCr 1  A9 23                lda #>ATTRIB_TABLE_0 ; horní bajt adresy $23c0
0000BEr 1  8D 06 20             sta PPUADDR
0000C1r 1  A9 C0                lda #<ATTRIB_TABLE_0 ; spodní bajt adresy $23c0
0000C3r 1  8D 06 20             sta PPUADDR
0000C6r 1  A2 00                ldx #$00             ; počitadlo smyčky
0000C8r 1               :
0000C8r 1  BD rr rr             lda attributedata,X
0000CBr 1  8D 07 20             sta PPUDATA          ; zápis indexu
0000CEr 1  E8                   inx                  ; zvýšení hodnoty počitadla
0000CFr 1  E0 08                cpx #$08             ; provádíme kopii osmi bajtů
0000D1r 1  D0 F5                bne :-
0000D3r 1               
0000D3r 1  60                   rts                  ; návrat ze subrutiny
0000D4r 1               .endproc
0000D4r 1               
0000D4r 1               
0000D4r 1               
0000D4r 1               ; samotná barvová paleta
0000D4r 1               palette:
0000D4r 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
0000D8r 1  22 36 17 0F  
0000DCr 1  22 30 21 0F  
0000E0r 1  22 27 17 0F  
0000E4r 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
0000E8r 1  22 1A 30 27  
0000ECr 1  22 16 30 27  
0000F0r 1  22 0F 36 17  
0000F4r 1               
0000F4r 1               
0000F4r 1               ; tabulka jmen
0000F4r 1               nametabledata:
0000F4r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; první řádek: nebe
0000F8r 1  24 24 24 24  
0000FCr 1  24 24 24 24  
000100r 1  24 24 24 24  
000104r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000108r 1  24 24 24 24  
00010Cr 1  24 24 24 24  
000110r 1  24 24 24 24  
000114r 1               
000114r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24  ; druhý řádek: nebe
000118r 1  24 24 24 24  
00011Cr 1  24 24 24 24  
000120r 1  24 24 24 24  
000124r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000128r 1  24 24 24 24  
00012Cr 1  24 24 24 24  
000130r 1  24 24 24 24  
000134r 1               
000134r 1  24 24 24 24      .byte $24,$24,$24,$24,$45,$45,$24,$24,$45,$45,$45,$45,$45,$45,$24,$24  ; třetí řádek
000138r 1  45 45 24 24  
00013Cr 1  45 45 45 45  
000140r 1  45 45 24 24  
000144r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24  ; různé cihly (horní polovina)
000148r 1  24 24 24 24  
00014Cr 1  24 24 24 24  
000150r 1  53 54 24 24  
000154r 1               
000154r 1  24 24 24 24      .byte $24,$24,$24,$24,$47,$47,$24,$24,$47,$47,$47,$47,$47,$47,$24,$24  ; čtvrtý řádek
000158r 1  47 47 24 24  
00015Cr 1  47 47 47 47  
000160r 1  47 47 24 24  
000164r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24  ; různé cihly (spodní polovina)
000168r 1  24 24 24 24  
00016Cr 1  24 24 24 24  
000170r 1  55 56 24 24  
000174r 1               
000174r 1               
000174r 1               ; tabulka atributů
000174r 1               attributedata:
000174r 1  00 10 20 00      .byte %00000000, %00010000, %00100000, %00000000, %00000000, %00000000, %00000000, %00110000
000178r 1  00 00 00 30  
00017Cr 1               
00017Cr 1               
00017Cr 1               
00017Cr 1               ; ---------------------------------------------------------------------
00017Cr 1               ; Tabulka vektorů CPU
00017Cr 1               ; ---------------------------------------------------------------------
00017Cr 1               
00017Cr 1               .segment "VECTORS"
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
