ca65 V2.18 - Ubuntu 2.18-1
Main file   : example28.asm
Current file: example28.asm

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
000000r 1               SCROLL          = $2005
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
000000r 1  A9 00                lda #0
000002r 1  8D 05 20             sta SCROLL        ; zákaz scrollingu
000005r 1  8D 05 20             sta SCROLL
000008r 1  A9 02                lda #$02          ; horní bajt adresy pro přenos + zahájení přenosu
00000Ar 1  8D 14 40             sta OAM_DMA
00000Dr 1  40                   rti               ; návrat z přerušení
00000Er 1               .endproc
00000Er 1               
00000Er 1               
00000Er 1               
00000Er 1               ; Obslužná rutina pro IRQ (maskovatelné přerušení)
00000Er 1               
00000Er 1               .proc irq
00000Er 1  40                   rti                     ; návrat z přerušení
00000Fr 1               .endproc
00000Fr 1               
00000Fr 1               
00000Fr 1               
00000Fr 1               ; Obslužná rutina pro RESET
00000Fr 1               
00000Fr 1               .proc reset
00000Fr 1                       ; nastavení stavu CPU
00000Fr 1  78 D8 A2 FF          setup_cpu
000013r 1  9A           
000014r 1               
000014r 1                       ; nastavení řídicích registrů
000014r 1  A2 40                ldx #$40
000016r 1  8E 17 40             stx $4017               ; zákaz IRQ z APU
000019r 1               
000019r 1  A2 00                ldx #$00
00001Br 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
00001Er 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
000021r 1  8E 10 40             stx DMC_FREQ            ; zákaz DMC IRQ
000024r 1               
000024r 1  A2 40                ldx #$40
000026r 1  8E 17 40             stx $4017               ; interrupt inhibit bit
000029r 1               
000029r 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
000029r 1  2C 02 20 10          wait_for_frame
00002Dr 1  FB           
00002Er 1  2C 02 20 10          wait_for_frame
000032r 1  FB           
000033r 1               
000033r 1                       ; vymazání obsahu RAM
000033r 1  A9 00 95 00          clear_ram
000037r 1  9D 00 01 9D  
00003Br 1  00 02 9D 00  
00003Fr 1  03 9D 00 04  
000043r 1  9D 00 05 9D  
000047r 1  00 06 9D 00  
00004Br 1  07 E8 D0 E6  
00004Fr 1               
00004Fr 1                       ; čekání na další snímek
00004Fr 1  2C 02 20 10          wait_for_frame
000053r 1  FB           
000054r 1               
000054r 1                       ; nastavení tabulek jmen
000054r 1  20 rr rr             jsr clear_nametables  ; zavolání subrutiny
000057r 1               
000057r 1                       ; nastavení barvové palety
000057r 1  20 rr rr             jsr load_palette      ; zavolání subrutiny
00005Ar 1               
00005Ar 1                       ; načtení tabulky jmen
00005Ar 1  20 rr rr             jsr load_nametable    ; zavolání subrutiny
00005Dr 1               
00005Dr 1                       ; načtení atributů
00005Dr 1  20 rr rr             jsr load_attributes   ; zavolání subrutiny
000060r 1               
000060r 1  A9 0E                lda #%00001110        ; povolení zobrazení pozadí, nikoli ovšem spritů
000062r 1  8D 01 20             sta PPUMASK
000065r 1               
000065r 1  58                   cli                   ; vynulování bitu I - povolení přerušení
000066r 1  A9 90                lda #%10010000
000068r 1  8D 00 20             sta PPUCTRL           ; při každém VBLANK se vyvolá NMI (důležité!)
00006Br 1               
00006Br 1                       ; vlastní herní smyčka je prozatím prázdná
00006Br 1               game_loop:
00006Br 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
00006Er 1               .endproc
00006Er 1               
00006Er 1               
00006Er 1               
00006Er 1               ; vynulování tabulek jmen
00006Er 1               .proc clear_nametables
00006Er 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
000071r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
000073r 1  8D 06 20             sta PPUADDR
000076r 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
000078r 1  8D 06 20             sta PPUADDR
00007Br 1  A2 08                ldx #$08           ; počitadlo stránek (8)
00007Dr 1  A0 00                ldy #$00           ; X a Y tvoří 16bitový čítač
00007Fr 1  A9 24                lda #$24           ; dlaždice číslo $24 představuje oblohu
000081r 1               :
000081r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
000084r 1  88                   dey                ; snížení hodnoty počitadla
000085r 1  D0 FA                bne :-             ; skok dokud se nezaplní celá stránka
000087r 1  CA                   dex                ; snížení hodnoty počitadla stránek
000088r 1  D0 F7                bne :-             ; skok dokud se nezaplní 8 stránek
00008Ar 1               
00008Ar 1  60                   rts                ; návrat ze subrutiny
00008Br 1               .endproc
00008Br 1               
00008Br 1               ; nastavení barvové palety
00008Br 1               .proc load_palette
00008Br 1  AD 02 20 A9          ppu_data_palette_address
00008Fr 1  3F 8D 06 20  
000093r 1  A9 00 8D 06  
000097r 1  20           
000098r 1               
000098r 1                       ; $3f00-$3f0f - paleta pozadí
000098r 1                       ; $3f10-$3f1f - paleta spritů
000098r 1               
000098r 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
00009Ar 1               
00009Ar 1               :
00009Ar 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
00009Dr 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
0000A0r 1  E8                   inx             ; zvýšit počitadlo/offset
0000A1r 1  E0 20                cpx #32         ; limit počtu barev
0000A3r 1  D0 F5                bne :-          ; opakovat smyčku 32x
0000A5r 1               
0000A5r 1  60                   rts             ; návrat ze subrutiny
0000A6r 1               .endproc
0000A6r 1               
0000A6r 1               
0000A6r 1               
0000A6r 1               ; načtení tabulky jmen
0000A6r 1               .proc load_nametable
0000A6r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
0000A9r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
0000ABr 1  8D 06 20             sta PPUADDR
0000AEr 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
0000B0r 1  8D 06 20             sta PPUADDR
0000B3r 1               
0000B3r 1  A2 00                ldx #$00           ; počitadlo
0000B5r 1               :
0000B5r 1  BD rr rr             lda nametabledata,X
0000B8r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0000BBr 1  E8                   inx
0000BCr 1  D0 F7                bne :-
0000BEr 1               
0000BEr 1  A2 00                ldx #$00           ; počitadlo
0000C0r 1               :
0000C0r 1  BD rr rr             lda nametabledata+256,X
0000C3r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0000C6r 1  E8                   inx
0000C7r 1  D0 F7                bne :-
0000C9r 1               
0000C9r 1  A2 00                ldx #$00           ; počitadlo
0000CBr 1               :
0000CBr 1  BD rr rr             lda nametabledata+512,X
0000CEr 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0000D1r 1  E8                   inx
0000D2r 1  D0 F7                bne :-
0000D4r 1               
0000D4r 1  60                   rts                ; návrat ze subrutiny
0000D5r 1               .endproc
0000D5r 1               
0000D5r 1               
0000D5r 1               
0000D5r 1               ; načtení atributů
0000D5r 1               .proc load_attributes
0000D5r 1  AD 02 20             lda PPUSTATUS        ; reset záchytného registru
0000D8r 1  A9 23                lda #>ATTRIB_TABLE_0 ; horní bajt adresy $23c0
0000DAr 1  8D 06 20             sta PPUADDR
0000DDr 1  A9 C0                lda #<ATTRIB_TABLE_0 ; spodní bajt adresy $23c0
0000DFr 1  8D 06 20             sta PPUADDR
0000E2r 1               
0000E2r 1  A2 00                ldx #0               ; počitadlo 64 bajtů
0000E4r 1               
0000E4r 1               :
0000E4r 1  BD rr rr             lda attributedata,X  ; načtení čtyř atributů
0000E7r 1  8D 07 20             sta PPUDATA          ; zápis indexu
0000EAr 1  E8                   inx                  ; snížení hodnoty počitadla
0000EBr 1  E0 40                cpx #64
0000EDr 1  D0 F5                bne :-               ; opakování smyčky
0000EFr 1               
0000EFr 1  60                   rts                  ; návrat ze subrutiny
0000F0r 1               .endproc
0000F0r 1               
0000F0r 1               
0000F0r 1               
0000F0r 1               ; samotná barvová paleta
0000F0r 1               palette:
0000F0r 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
0000F4r 1  22 36 17 0F  
0000F8r 1  22 30 21 0F  
0000FCr 1  22 27 17 0F  
000100r 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
000104r 1  22 1A 30 27  
000108r 1  22 16 30 27  
00010Cr 1  22 0F 36 17  
000110r 1               
000110r 1               
000110r 1               ; tabulka jmen
000110r 1               nametabledata:
000110r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000114r 1  24 24 24 24  
000118r 1  24 24 24 24  
00011Cr 1  24 24 24 24  
000120r 1  24 24 24 24  
000124r 1  24 24 24 24  
000128r 1  24 24 24 24  
00012Cr 1  24 24 24 24  
000130r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$D0,$E8,$D1,$D0,$D1,$DE,$D1,$D8,$D0,$D1,$26,$29,$29,$DE,$D1,$D0,$D1,$D0,$D1,$26,$24,$24,$24,$24,$24,$24
000134r 1  24 24 D0 E8  
000138r 1  D1 D0 D1 DE  
00013Cr 1  D1 D8 D0 D1  
000140r 1  26 29 29 DE  
000144r 1  D1 D0 D1 D0  
000148r 1  D1 26 24 24  
00014Cr 1  24 24 24 24  
000150r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$42,$42,$DB,$42,$DB,$42,$DB,$DB,$42,$26,$29,$29,$DB,$42,$DB,$42,$DB,$42,$26,$24,$24,$24,$24,$24,$24
000154r 1  24 24 DB 42  
000158r 1  42 DB 42 DB  
00015Cr 1  42 DB DB 42  
000160r 1  26 29 29 DB  
000164r 1  42 DB 42 DB  
000168r 1  42 26 24 24  
00016Cr 1  24 24 24 24  
000170r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$DB,$DE,$DF,$DB,$DB,$DB,$26,$29,$29,$DE,$DF,$DB,$DB,$E4,$E5,$26,$24,$24,$24,$24,$24,$24
000174r 1  24 24 DB DB  
000178r 1  DB DB DB DE  
00017Cr 1  DF DB DB DB  
000180r 1  26 29 29 DE  
000184r 1  DF DB DB E4  
000188r 1  E5 26 24 24  
00018Cr 1  24 24 24 24  
000190r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DE,$43,$DB,$42,$DB,$DB,$DB,$26,$29,$29,$DB,$42,$DB,$DB,$E6,$E3,$26,$24,$24,$24,$24,$24,$24
000194r 1  24 24 DB DB  
000198r 1  DB DE 43 DB  
00019Cr 1  42 DB DB DB  
0001A0r 1  26 29 29 DB  
0001A4r 1  42 DB DB E6  
0001A8r 1  E3 26 24 24  
0001ACr 1  24 24 24 24  
0001B0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$42,$DB,$DB,$DB,$D4,$D9,$26,$29,$29,$DB,$DB,$D4,$D9,$D4,$D9,$E7,$24,$24,$24,$24,$24,$24
0001B4r 1  24 24 DB DB  
0001B8r 1  DB DB 42 DB  
0001BCr 1  DB DB D4 D9  
0001C0r 1  26 29 29 DB  
0001C4r 1  DB D4 D9 D4  
0001C8r 1  D9 E7 24 24  
0001CCr 1  24 24 24 24  
0001D0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$95,$95,$95,$95,$95,$95,$95,$95,$97,$98,$78,$78,$78,$95,$95,$97,$98,$97,$98,$95,$24,$24,$24,$24,$24,$24
0001D4r 1  24 24 95 95  
0001D8r 1  95 95 95 95  
0001DCr 1  95 95 97 98  
0001E0r 1  78 78 78 95  
0001E4r 1  95 97 98 97  
0001E8r 1  98 95 24 24  
0001ECr 1  24 24 24 24  
0001F0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
0001F4r 1  24 24 24 24  
0001F8r 1  24 24 24 24  
0001FCr 1  24 24 24 24  
000200r 1  24 24 24 24  
000204r 1  24 24 24 24  
000208r 1  24 24 24 24  
00020Cr 1  24 24 24 24  
000210r 1               
000210r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000214r 1  24 24 24 24  
000218r 1  24 24 24 24  
00021Cr 1  24 24 24 24  
000220r 1  24 24 24 24  
000224r 1  24 24 24 24  
000228r 1  24 24 24 24  
00022Cr 1  24 24 24 24  
000230r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$D0,$E8,$D1,$D0,$D1,$DE,$D1,$D8,$D0,$D1,$26,$29,$29,$DE,$D1,$D0,$D1,$D0,$D1,$26,$24,$24,$24,$24,$24,$24
000234r 1  24 24 D0 E8  
000238r 1  D1 D0 D1 DE  
00023Cr 1  D1 D8 D0 D1  
000240r 1  26 29 29 DE  
000244r 1  D1 D0 D1 D0  
000248r 1  D1 26 24 24  
00024Cr 1  24 24 24 24  
000250r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$42,$42,$DB,$42,$DB,$42,$DB,$DB,$42,$26,$29,$29,$DB,$42,$DB,$42,$DB,$42,$26,$24,$24,$24,$24,$24,$24
000254r 1  24 24 DB 42  
000258r 1  42 DB 42 DB  
00025Cr 1  42 DB DB 42  
000260r 1  26 29 29 DB  
000264r 1  42 DB 42 DB  
000268r 1  42 26 24 24  
00026Cr 1  24 24 24 24  
000270r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$DB,$DE,$DF,$DB,$DB,$DB,$26,$29,$29,$DE,$DF,$DB,$DB,$E4,$E5,$26,$24,$24,$24,$24,$24,$24
000274r 1  24 24 DB DB  
000278r 1  DB DB DB DE  
00027Cr 1  DF DB DB DB  
000280r 1  26 29 29 DE  
000284r 1  DF DB DB E4  
000288r 1  E5 26 24 24  
00028Cr 1  24 24 24 24  
000290r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DE,$43,$DB,$42,$DB,$DB,$DB,$26,$29,$29,$DB,$42,$DB,$DB,$E6,$E3,$26,$24,$24,$24,$24,$24,$24
000294r 1  24 24 DB DB  
000298r 1  DB DE 43 DB  
00029Cr 1  42 DB DB DB  
0002A0r 1  26 29 29 DB  
0002A4r 1  42 DB DB E6  
0002A8r 1  E3 26 24 24  
0002ACr 1  24 24 24 24  
0002B0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$42,$DB,$DB,$DB,$D4,$D9,$26,$29,$29,$DB,$DB,$D4,$D9,$D4,$D9,$E7,$24,$24,$24,$24,$24,$24
0002B4r 1  24 24 DB DB  
0002B8r 1  DB DB 42 DB  
0002BCr 1  DB DB D4 D9  
0002C0r 1  26 29 29 DB  
0002C4r 1  DB D4 D9 D4  
0002C8r 1  D9 E7 24 24  
0002CCr 1  24 24 24 24  
0002D0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$95,$95,$95,$95,$95,$95,$95,$95,$97,$98,$78,$78,$78,$95,$95,$97,$98,$97,$98,$95,$24,$24,$24,$24,$24,$24
0002D4r 1  24 24 95 95  
0002D8r 1  95 95 95 95  
0002DCr 1  95 95 97 98  
0002E0r 1  78 78 78 95  
0002E4r 1  95 97 98 97  
0002E8r 1  98 95 24 24  
0002ECr 1  24 24 24 24  
0002F0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
0002F4r 1  24 24 24 24  
0002F8r 1  24 24 24 24  
0002FCr 1  24 24 24 24  
000300r 1  24 24 24 24  
000304r 1  24 24 24 24  
000308r 1  24 24 24 24  
00030Cr 1  24 24 24 24  
000310r 1               
000310r 1  24 1B 18 18      .byte $24,$1b,$18,$18,$1d,$24,$25,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000314r 1  1D 24 25 24  
000318r 1  24 24 24 24  
00031Cr 1  24 24 24 24  
000320r 1  24 24 24 24  
000324r 1  24 24 24 24  
000328r 1  24 24 24 24  
00032Cr 1  24 24 24 24  
000330r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000334r 1  24 24 24 24  
000338r 1  24 24 24 24  
00033Cr 1  24 24 24 24  
000340r 1  24 A5 A6 24  
000344r 1  24 24 24 24  
000348r 1  24 24 24 24  
00034Cr 1  24 24 24 24  
000350r 1  24 24 A5 A6      .byte $24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24,$24,$a7,$a8,$24,$45,$45,$24,$24,$45,$45,$45,$45,$53,$54,$24,$24
000354r 1  24 24 24 24  
000358r 1  24 24 24 24  
00035Cr 1  53 54 24 24  
000360r 1  24 A7 A8 24  
000364r 1  45 45 24 24  
000368r 1  45 45 45 45  
00036Cr 1  53 54 24 24  
000370r 1  24 24 A7 A8      .byte $24,$24,$a7,$a8,$47,$47,$24,$24,$47,$47,$47,$47,$55,$56,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24
000374r 1  47 47 24 24  
000378r 1  47 47 47 47  
00037Cr 1  55 56 24 24  
000380r 1  24 24 24 24  
000384r 1  24 24 24 24  
000388r 1  24 24 24 24  
00038Cr 1  55 56 24 24  
000390r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000394r 1  24 24 24 24  
000398r 1  24 24 24 24  
00039Cr 1  24 24 24 24  
0003A0r 1  24 24 24 24  
0003A4r 1  24 24 24 24  
0003A8r 1  24 24 24 24  
0003ACr 1  24 24 24 24  
0003B0r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
0003B4r 1  24 24 24 24  
0003B8r 1  24 24 24 24  
0003BCr 1  24 24 24 24  
0003C0r 1  24 A5 A6 24  
0003C4r 1  24 24 24 24  
0003C8r 1  24 24 24 24  
0003CCr 1  24 24 24 24  
0003D0r 1  24 24 A5 A6      .byte $24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24,$24,$a7,$a8,$24,$45,$45,$24,$24,$45,$45,$45,$45,$53,$54,$24,$24
0003D4r 1  24 24 24 24  
0003D8r 1  24 24 24 24  
0003DCr 1  53 54 24 24  
0003E0r 1  24 A7 A8 24  
0003E4r 1  45 45 24 24  
0003E8r 1  45 45 45 45  
0003ECr 1  53 54 24 24  
0003F0r 1  24 24 A7 A8      .byte $24,$24,$a7,$a8,$47,$47,$24,$24,$47,$47,$47,$47,$55,$56,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24
0003F4r 1  47 47 24 24  
0003F8r 1  47 47 47 47  
0003FCr 1  55 56 24 24  
000400r 1  24 24 24 24  
000404r 1  24 24 24 24  
000408r 1  24 24 24 24  
00040Cr 1  55 56 24 24  
000410r 1               
000410r 1               ; tabulka atributů
000410r 1               attributedata:
000410r 1  FF FF FF FF      .byte %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111 ; žluto-hnědá paleta
000414r 1  FF FF FF FF  
000418r 1  FF FF FF FF      .byte %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
00041Cr 1  FF FF FF FF  
000420r 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000 ; zelená paleta
000424r 1  00 00 00 00  
000428r 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
00042Cr 1  00 00 00 00  
000430r 1  AA AA AA BF      .byte %10101010, %10101010, %10101010, %10111111, %11111111, %10101010, %11111111, %10101010
000434r 1  FF AA FF AA  
000438r 1  55 AA 55 EF      .byte %01010101, %10101010, %01010101, %11101111, %11111111, %01010101, %11111111, %01010101
00043Cr 1  FF 55 FF 55  
000440r 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000 ; jen obloha - průhledné pixely
000444r 1  00 00 00 00  
000448r 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
00044Cr 1  00 00 00 00  
000450r 1               
000450r 1               
000450r 1               
000450r 1               ; ---------------------------------------------------------------------
000450r 1               ; Tabulka vektorů CPU
000450r 1               ; ---------------------------------------------------------------------
000450r 1               
000450r 1               .segment "VECTORS"
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
