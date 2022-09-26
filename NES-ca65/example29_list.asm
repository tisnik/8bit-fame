ca65 V2.18 - Ubuntu 2.18-1
Main file   : example29.asm
Current file: example29.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity barvy
000000r 1               ; Setup PPU přes makro
000000r 1               ; Definice pozadí a zobrazení pozadí.
000000r 1               ; Scrolling pozadí s využitím ovladače.
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
000000r 1               ; Ovladače
000000r 1               JOYPAD1         = $4016
000000r 1               JOYPAD2         = $4017
000000r 1               
000000r 1               ; Adresy globálních proměnných
000000r 1               XSCROLL         = $0203       ; adresa buňky paměti pro scrolling ve směru x-ové osy
000000r 1               YSCROLL         = $0200       ; adresa buňky paměti pro scrolling ve směru y-ové osy
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
000000r 1  A9 01                lda #$01
000002r 1  8D 16 40             sta JOYPAD1           ; načtení stavu všech osmi tlačítek do záchytného registru
000005r 1  A9 00                lda #$00
000007r 1  8D 16 40             sta JOYPAD1           ; začátek načítání jednotlivých bitů se stavy tlačítek v tomto pořadí:
00000Ar 1                                             ;
00000Ar 1                                             ; 1) A
00000Ar 1                                             ; 2) B
00000Ar 1                                             ; 3) Select
00000Ar 1                                             ; 4) Start
00000Ar 1                                             ; 5) Up
00000Ar 1                                             ; 6) Down
00000Ar 1                                             ; 7) Left
00000Ar 1                                             ; 8) Right
00000Ar 1               
00000Ar 1  AD 16 40 29          read_button           ; detekce stisku tlačítka A
00000Er 1  01           
00000Fr 1  AD 16 40 29          read_button           ; detekce stisku tlačítka B
000013r 1  01           
000014r 1  AD 16 40 29          read_button           ; detekce stisku tlačítka Select
000018r 1  01           
000019r 1  AD 16 40 29          read_button           ; detekce stisku tlačítka Start
00001Dr 1  01           
00001Er 1               
00001Er 1  AD 16 40 29          read_button           ; detekce stisku tlačítka Up
000022r 1  01           
000023r 1  F0 03                beq up_not_pressed    ; není stisknuto? => skok
000025r 1  EE 00 02             inc YSCROLL           ; zvýšení offsetu
000028r 1               
000028r 1               up_not_pressed:
000028r 1  AD 16 40 29          read_button           ; detekce stisku tlačítka Down
00002Cr 1  01           
00002Dr 1  F0 03                beq down_not_pressed  ; není stisknuto? => skok
00002Fr 1  CE 00 02             dec YSCROLL           ; snížení offsetu
000032r 1               
000032r 1               down_not_pressed:
000032r 1  AD 16 40 29          read_button           ; detekce stisku tlačítka Left
000036r 1  01           
000037r 1  F0 03                beq left_not_pressed  ; není stisknuto? => skok
000039r 1  EE 03 02             inc XSCROLL           ; zvýšení offsetu
00003Cr 1               
00003Cr 1               left_not_pressed:
00003Cr 1  AD 16 40 29          read_button           ; detekce stisku tlačítka Right
000040r 1  01           
000041r 1  F0 03                beq right_not_pressed ; není stisknuto? => skok
000043r 1  CE 03 02             dec XSCROLL           ; snížení offsetu
000046r 1               
000046r 1               right_not_pressed:
000046r 1  AD 03 02             lda XSCROLL           ; nastavení scrollingu
000049r 1  8D 05 20             sta SCROLL
00004Cr 1  AD 00 02             lda YSCROLL
00004Fr 1  8D 05 20             sta SCROLL
000052r 1               
000052r 1  A9 02                lda #$02              ; horní bajt adresy pro přenos + zahájení přenosu
000054r 1  8D 14 40             sta OAM_DMA
000057r 1  40                   rti                   ; návrat z přerušení
000058r 1               .endproc
000058r 1               
000058r 1               
000058r 1               
000058r 1               ; Obslužná rutina pro IRQ (maskovatelné přerušení)
000058r 1               
000058r 1               .proc irq
000058r 1  40                   rti                   ; návrat z přerušení
000059r 1               .endproc
000059r 1               
000059r 1               
000059r 1               
000059r 1               ; Obslužná rutina pro RESET
000059r 1               
000059r 1               .proc reset
000059r 1                       ; nastavení stavu CPU
000059r 1  78 D8 A2 FF          setup_cpu
00005Dr 1  9A           
00005Er 1               
00005Er 1                       ; nastavení řídicích registrů
00005Er 1  A2 40                ldx #$40
000060r 1  8E 17 40             stx $4017               ; zákaz IRQ z APU
000063r 1               
000063r 1  A2 00                ldx #$00
000065r 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0 (NMI)
000068r 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
00006Br 1  8E 10 40             stx DMC_FREQ            ; zákaz DMC IRQ
00006Er 1               
00006Er 1  A2 40                ldx #$40
000070r 1  8E 17 40             stx $4017               ; interrupt inhibit bit
000073r 1               
000073r 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
000073r 1  2C 02 20 10          wait_for_frame
000077r 1  FB           
000078r 1  2C 02 20 10          wait_for_frame
00007Cr 1  FB           
00007Dr 1               
00007Dr 1                       ; vymazání obsahu RAM
00007Dr 1  A9 00 95 00          clear_ram
000081r 1  9D 00 01 9D  
000085r 1  00 02 9D 00  
000089r 1  03 9D 00 04  
00008Dr 1  9D 00 05 9D  
000091r 1  00 06 9D 00  
000095r 1  07 E8 D0 E6  
000099r 1               
000099r 1                       ; čekání na další snímek
000099r 1  2C 02 20 10          wait_for_frame
00009Dr 1  FB           
00009Er 1               
00009Er 1                       ; nastavení tabulek jmen
00009Er 1  20 rr rr             jsr clear_nametables  ; zavolání subrutiny
0000A1r 1               
0000A1r 1                       ; nastavení barvové palety
0000A1r 1  20 rr rr             jsr load_palette      ; zavolání subrutiny
0000A4r 1               
0000A4r 1                       ; načtení tabulky jmen
0000A4r 1  20 rr rr             jsr load_nametable    ; zavolání subrutiny
0000A7r 1               
0000A7r 1                       ; načtení atributů
0000A7r 1  20 rr rr             jsr load_attributes   ; zavolání subrutiny
0000AAr 1               
0000AAr 1  A9 0E                lda #%00001110        ; povolení zobrazení pozadí, nikoli ovšem spritů
0000ACr 1  8D 01 20             sta PPUMASK
0000AFr 1               
0000AFr 1  A9 00                lda #0                ; vynulovat počitadlo spritů
0000B1r 1  8D 03 02             sta XSCROLL
0000B4r 1  8D 00 02             sta YSCROLL
0000B7r 1               
0000B7r 1  58                   cli                   ; vynulování bitu I - povolení přerušení
0000B8r 1  A9 90                lda #%10010000
0000BAr 1  8D 00 20             sta PPUCTRL           ; při každém VBLANK se vyvolá NMI (důležité!)
0000BDr 1               
0000BDr 1                       ; vlastní herní smyčka je prozatím prázdná
0000BDr 1               game_loop:
0000BDr 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
0000C0r 1               .endproc
0000C0r 1               
0000C0r 1               
0000C0r 1               
0000C0r 1               ; vynulování tabulek jmen
0000C0r 1               .proc clear_nametables
0000C0r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
0000C3r 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
0000C5r 1  8D 06 20             sta PPUADDR
0000C8r 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
0000CAr 1  8D 06 20             sta PPUADDR
0000CDr 1  A2 08                ldx #$08           ; počitadlo stránek (8)
0000CFr 1  A0 00                ldy #$00           ; X a Y tvoří 16bitový čítač
0000D1r 1  A9 24                lda #$24           ; dlaždice číslo $24 představuje oblohu
0000D3r 1               :
0000D3r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
0000D6r 1  88                   dey                ; snížení hodnoty počitadla
0000D7r 1  D0 FA                bne :-             ; skok dokud se nezaplní celá stránka
0000D9r 1  CA                   dex                ; snížení hodnoty počitadla stránek
0000DAr 1  D0 F7                bne :-             ; skok dokud se nezaplní 8 stránek
0000DCr 1               
0000DCr 1  60                   rts                ; návrat ze subrutiny
0000DDr 1               .endproc
0000DDr 1               
0000DDr 1               ; nastavení barvové palety
0000DDr 1               .proc load_palette
0000DDr 1  AD 02 20 A9          ppu_data_palette_address
0000E1r 1  3F 8D 06 20  
0000E5r 1  A9 00 8D 06  
0000E9r 1  20           
0000EAr 1               
0000EAr 1                       ; $3f00-$3f0f - paleta pozadí
0000EAr 1                       ; $3f10-$3f1f - paleta spritů
0000EAr 1               
0000EAr 1  A2 00                ldx #$00        ; vynulovat počitadlo a offset
0000ECr 1               
0000ECr 1               :
0000ECr 1  BD rr rr             lda palette, x  ; načíst bajt s offsetem
0000EFr 1  8D 07 20             sta PPUDATA     ; zápis barvy do PPU
0000F2r 1  E8                   inx             ; zvýšit počitadlo/offset
0000F3r 1  E0 20                cpx #32         ; limit počtu barev
0000F5r 1  D0 F5                bne :-          ; opakovat smyčku 32x
0000F7r 1               
0000F7r 1  60                   rts             ; návrat ze subrutiny
0000F8r 1               .endproc
0000F8r 1               
0000F8r 1               
0000F8r 1               
0000F8r 1               ; načtení tabulky jmen
0000F8r 1               .proc load_nametable
0000F8r 1  AD 02 20             lda PPUSTATUS      ; reset záchytného registru
0000FBr 1  A9 20                lda #>NAME_TABLE_0 ; horní bajt adresy
0000FDr 1  8D 06 20             sta PPUADDR
000100r 1  A9 00                lda #<NAME_TABLE_0 ; spodní bajt adresy
000102r 1  8D 06 20             sta PPUADDR
000105r 1               
000105r 1  A2 00                ldx #$00           ; počitadlo
000107r 1               :
000107r 1  BD rr rr             lda nametabledata,X
00010Ar 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
00010Dr 1  E8                   inx
00010Er 1  D0 F7                bne :-
000110r 1               
000110r 1  A2 00                ldx #$00           ; počitadlo
000112r 1               :
000112r 1  BD rr rr             lda nametabledata+256,X
000115r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
000118r 1  E8                   inx
000119r 1  D0 F7                bne :-
00011Br 1               
00011Br 1  A2 00                ldx #$00           ; počitadlo
00011Dr 1               :
00011Dr 1  BD rr rr             lda nametabledata+512,X
000120r 1  8D 07 20             sta PPUDATA        ; zápis indexu dlaždice
000123r 1  E8                   inx
000124r 1  D0 F7                bne :-
000126r 1               
000126r 1  60                   rts                ; návrat ze subrutiny
000127r 1               .endproc
000127r 1               
000127r 1               
000127r 1               
000127r 1               ; načtení atributů
000127r 1               .proc load_attributes
000127r 1  AD 02 20             lda PPUSTATUS        ; reset záchytného registru
00012Ar 1  A9 23                lda #>ATTRIB_TABLE_0 ; horní bajt adresy $23c0
00012Cr 1  8D 06 20             sta PPUADDR
00012Fr 1  A9 C0                lda #<ATTRIB_TABLE_0 ; spodní bajt adresy $23c0
000131r 1  8D 06 20             sta PPUADDR
000134r 1               
000134r 1  A2 00                ldx #0               ; počitadlo 64 bajtů
000136r 1               
000136r 1               :
000136r 1  BD rr rr             lda attributedata,X  ; načtení čtyř atributů
000139r 1  8D 07 20             sta PPUDATA          ; zápis indexu
00013Cr 1  E8                   inx                  ; snížení hodnoty počitadla
00013Dr 1  E0 40                cpx #64
00013Fr 1  D0 F5                bne :-               ; opakování smyčky
000141r 1               
000141r 1  60                   rts                  ; návrat ze subrutiny
000142r 1               .endproc
000142r 1               
000142r 1               
000142r 1               
000142r 1               ; samotná barvová paleta
000142r 1               palette:
000142r 1  22 29 1A 0F      .byte $22, $29, $1a, $0F, $22, $36, $17, $0F, $22, $30, $21, $0F, $22, $27, $17, $0F  ; barvy pozadí
000146r 1  22 36 17 0F  
00014Ar 1  22 30 21 0F  
00014Er 1  22 27 17 0F  
000152r 1  22 16 27 18      .byte $22, $16, $27, $18, $22, $1A, $30, $27, $22, $16, $30, $27, $22, $0F, $36, $17  ; barvy spritů
000156r 1  22 1A 30 27  
00015Ar 1  22 16 30 27  
00015Er 1  22 0F 36 17  
000162r 1               
000162r 1               
000162r 1               ; tabulka jmen
000162r 1               nametabledata:
000162r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000166r 1  24 24 24 24  
00016Ar 1  24 24 24 24  
00016Er 1  24 24 24 24  
000172r 1  24 24 24 24  
000176r 1  24 24 24 24  
00017Ar 1  24 24 24 24  
00017Er 1  24 24 24 24  
000182r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$D0,$E8,$D1,$D0,$D1,$DE,$D1,$D8,$D0,$D1,$26,$29,$29,$DE,$D1,$D0,$D1,$D0,$D1,$26,$24,$24,$24,$24,$24,$24
000186r 1  24 24 D0 E8  
00018Ar 1  D1 D0 D1 DE  
00018Er 1  D1 D8 D0 D1  
000192r 1  26 29 29 DE  
000196r 1  D1 D0 D1 D0  
00019Ar 1  D1 26 24 24  
00019Er 1  24 24 24 24  
0001A2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$42,$42,$DB,$42,$DB,$42,$DB,$DB,$42,$26,$29,$29,$DB,$42,$DB,$42,$DB,$42,$26,$24,$24,$24,$24,$24,$24
0001A6r 1  24 24 DB 42  
0001AAr 1  42 DB 42 DB  
0001AEr 1  42 DB DB 42  
0001B2r 1  26 29 29 DB  
0001B6r 1  42 DB 42 DB  
0001BAr 1  42 26 24 24  
0001BEr 1  24 24 24 24  
0001C2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$DB,$DE,$DF,$DB,$DB,$DB,$26,$29,$29,$DE,$DF,$DB,$DB,$E4,$E5,$26,$24,$24,$24,$24,$24,$24
0001C6r 1  24 24 DB DB  
0001CAr 1  DB DB DB DE  
0001CEr 1  DF DB DB DB  
0001D2r 1  26 29 29 DE  
0001D6r 1  DF DB DB E4  
0001DAr 1  E5 26 24 24  
0001DEr 1  24 24 24 24  
0001E2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DE,$43,$DB,$42,$DB,$DB,$DB,$26,$29,$29,$DB,$42,$DB,$DB,$E6,$E3,$26,$24,$24,$24,$24,$24,$24
0001E6r 1  24 24 DB DB  
0001EAr 1  DB DE 43 DB  
0001EEr 1  42 DB DB DB  
0001F2r 1  26 29 29 DB  
0001F6r 1  42 DB DB E6  
0001FAr 1  E3 26 24 24  
0001FEr 1  24 24 24 24  
000202r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$42,$DB,$DB,$DB,$D4,$D9,$26,$29,$29,$DB,$DB,$D4,$D9,$D4,$D9,$E7,$24,$24,$24,$24,$24,$24
000206r 1  24 24 DB DB  
00020Ar 1  DB DB 42 DB  
00020Er 1  DB DB D4 D9  
000212r 1  26 29 29 DB  
000216r 1  DB D4 D9 D4  
00021Ar 1  D9 E7 24 24  
00021Er 1  24 24 24 24  
000222r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$95,$95,$95,$95,$95,$95,$95,$95,$97,$98,$78,$78,$78,$95,$95,$97,$98,$97,$98,$95,$24,$24,$24,$24,$24,$24
000226r 1  24 24 95 95  
00022Ar 1  95 95 95 95  
00022Er 1  95 95 97 98  
000232r 1  78 78 78 95  
000236r 1  95 97 98 97  
00023Ar 1  98 95 24 24  
00023Er 1  24 24 24 24  
000242r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000246r 1  24 24 24 24  
00024Ar 1  24 24 24 24  
00024Er 1  24 24 24 24  
000252r 1  24 24 24 24  
000256r 1  24 24 24 24  
00025Ar 1  24 24 24 24  
00025Er 1  24 24 24 24  
000262r 1               
000262r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000266r 1  24 24 24 24  
00026Ar 1  24 24 24 24  
00026Er 1  24 24 24 24  
000272r 1  24 24 24 24  
000276r 1  24 24 24 24  
00027Ar 1  24 24 24 24  
00027Er 1  24 24 24 24  
000282r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$D0,$E8,$D1,$D0,$D1,$DE,$D1,$D8,$D0,$D1,$26,$29,$29,$DE,$D1,$D0,$D1,$D0,$D1,$26,$24,$24,$24,$24,$24,$24
000286r 1  24 24 D0 E8  
00028Ar 1  D1 D0 D1 DE  
00028Er 1  D1 D8 D0 D1  
000292r 1  26 29 29 DE  
000296r 1  D1 D0 D1 D0  
00029Ar 1  D1 26 24 24  
00029Er 1  24 24 24 24  
0002A2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$42,$42,$DB,$42,$DB,$42,$DB,$DB,$42,$26,$29,$29,$DB,$42,$DB,$42,$DB,$42,$26,$24,$24,$24,$24,$24,$24
0002A6r 1  24 24 DB 42  
0002AAr 1  42 DB 42 DB  
0002AEr 1  42 DB DB 42  
0002B2r 1  26 29 29 DB  
0002B6r 1  42 DB 42 DB  
0002BAr 1  42 26 24 24  
0002BEr 1  24 24 24 24  
0002C2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$DB,$DE,$DF,$DB,$DB,$DB,$26,$29,$29,$DE,$DF,$DB,$DB,$E4,$E5,$26,$24,$24,$24,$24,$24,$24
0002C6r 1  24 24 DB DB  
0002CAr 1  DB DB DB DE  
0002CEr 1  DF DB DB DB  
0002D2r 1  26 29 29 DE  
0002D6r 1  DF DB DB E4  
0002DAr 1  E5 26 24 24  
0002DEr 1  24 24 24 24  
0002E2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DE,$43,$DB,$42,$DB,$DB,$DB,$26,$29,$29,$DB,$42,$DB,$DB,$E6,$E3,$26,$24,$24,$24,$24,$24,$24
0002E6r 1  24 24 DB DB  
0002EAr 1  DB DE 43 DB  
0002EEr 1  42 DB DB DB  
0002F2r 1  26 29 29 DB  
0002F6r 1  42 DB DB E6  
0002FAr 1  E3 26 24 24  
0002FEr 1  24 24 24 24  
000302r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$DB,$DB,$DB,$DB,$42,$DB,$DB,$DB,$D4,$D9,$26,$29,$29,$DB,$DB,$D4,$D9,$D4,$D9,$E7,$24,$24,$24,$24,$24,$24
000306r 1  24 24 DB DB  
00030Ar 1  DB DB 42 DB  
00030Er 1  DB DB D4 D9  
000312r 1  26 29 29 DB  
000316r 1  DB D4 D9 D4  
00031Ar 1  D9 E7 24 24  
00031Er 1  24 24 24 24  
000322r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$95,$95,$95,$95,$95,$95,$95,$95,$97,$98,$78,$78,$78,$95,$95,$97,$98,$97,$98,$95,$24,$24,$24,$24,$24,$24
000326r 1  24 24 95 95  
00032Ar 1  95 95 95 95  
00032Er 1  95 95 97 98  
000332r 1  78 78 78 95  
000336r 1  95 97 98 97  
00033Ar 1  98 95 24 24  
00033Er 1  24 24 24 24  
000342r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000346r 1  24 24 24 24  
00034Ar 1  24 24 24 24  
00034Er 1  24 24 24 24  
000352r 1  24 24 24 24  
000356r 1  24 24 24 24  
00035Ar 1  24 24 24 24  
00035Er 1  24 24 24 24  
000362r 1               
000362r 1  24 1B 18 18      .byte $24,$1b,$18,$18,$1d,$24,$25,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000366r 1  1D 24 25 24  
00036Ar 1  24 24 24 24  
00036Er 1  24 24 24 24  
000372r 1  24 24 24 24  
000376r 1  24 24 24 24  
00037Ar 1  24 24 24 24  
00037Er 1  24 24 24 24  
000382r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000386r 1  24 24 24 24  
00038Ar 1  24 24 24 24  
00038Er 1  24 24 24 24  
000392r 1  24 A5 A6 24  
000396r 1  24 24 24 24  
00039Ar 1  24 24 24 24  
00039Er 1  24 24 24 24  
0003A2r 1  24 24 A5 A6      .byte $24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24,$24,$a7,$a8,$24,$45,$45,$24,$24,$45,$45,$45,$45,$53,$54,$24,$24
0003A6r 1  24 24 24 24  
0003AAr 1  24 24 24 24  
0003AEr 1  53 54 24 24  
0003B2r 1  24 A7 A8 24  
0003B6r 1  45 45 24 24  
0003BAr 1  45 45 45 45  
0003BEr 1  53 54 24 24  
0003C2r 1  24 24 A7 A8      .byte $24,$24,$a7,$a8,$47,$47,$24,$24,$47,$47,$47,$47,$55,$56,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24
0003C6r 1  47 47 24 24  
0003CAr 1  47 47 47 47  
0003CEr 1  55 56 24 24  
0003D2r 1  24 24 24 24  
0003D6r 1  24 24 24 24  
0003DAr 1  24 24 24 24  
0003DEr 1  55 56 24 24  
0003E2r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
0003E6r 1  24 24 24 24  
0003EAr 1  24 24 24 24  
0003EEr 1  24 24 24 24  
0003F2r 1  24 24 24 24  
0003F6r 1  24 24 24 24  
0003FAr 1  24 24 24 24  
0003FEr 1  24 24 24 24  
000402r 1  24 24 24 24      .byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
000406r 1  24 24 24 24  
00040Ar 1  24 24 24 24  
00040Er 1  24 24 24 24  
000412r 1  24 A5 A6 24  
000416r 1  24 24 24 24  
00041Ar 1  24 24 24 24  
00041Er 1  24 24 24 24  
000422r 1  24 24 A5 A6      .byte $24,$24,$a5,$a6,$24,$24,$24,$24,$24,$24,$24,$24,$53,$54,$24,$24,$24,$a7,$a8,$24,$45,$45,$24,$24,$45,$45,$45,$45,$53,$54,$24,$24
000426r 1  24 24 24 24  
00042Ar 1  24 24 24 24  
00042Er 1  53 54 24 24  
000432r 1  24 A7 A8 24  
000436r 1  45 45 24 24  
00043Ar 1  45 45 45 45  
00043Er 1  53 54 24 24  
000442r 1  24 24 A7 A8      .byte $24,$24,$a7,$a8,$47,$47,$24,$24,$47,$47,$47,$47,$55,$56,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24
000446r 1  47 47 24 24  
00044Ar 1  47 47 47 47  
00044Er 1  55 56 24 24  
000452r 1  24 24 24 24  
000456r 1  24 24 24 24  
00045Ar 1  24 24 24 24  
00045Er 1  55 56 24 24  
000462r 1               
000462r 1               ; tabulka atributů
000462r 1               attributedata:
000462r 1  FF FF FF FF      .byte %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111 ; žluto-hnědá paleta
000466r 1  FF FF FF FF  
00046Ar 1  FF FF FF FF      .byte %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111, %11111111
00046Er 1  FF FF FF FF  
000472r 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000 ; zelená paleta
000476r 1  00 00 00 00  
00047Ar 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
00047Er 1  00 00 00 00  
000482r 1  AA AA AA BF      .byte %10101010, %10101010, %10101010, %10111111, %11111111, %10101010, %11111111, %10101010
000486r 1  FF AA FF AA  
00048Ar 1  55 AA 55 EF      .byte %01010101, %10101010, %01010101, %11101111, %11111111, %01010101, %11111111, %01010101
00048Er 1  FF 55 FF 55  
000492r 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000 ; jen obloha - průhledné pixely
000496r 1  00 00 00 00  
00049Ar 1  00 00 00 00      .byte %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000, %00000000
00049Er 1  00 00 00 00  
0004A2r 1               
0004A2r 1               
0004A2r 1               
0004A2r 1               ; ---------------------------------------------------------------------
0004A2r 1               ; Tabulka vektorů CPU
0004A2r 1               ; ---------------------------------------------------------------------
0004A2r 1               
0004A2r 1               .segment "VECTORS"
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
