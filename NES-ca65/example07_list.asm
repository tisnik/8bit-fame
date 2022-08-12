ca65 V2.18 - Ubuntu 2.18-1
Main file   : example07.asm
Current file: example07.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Kostra programu pro herní konzoli NES
000000r 1               ; Nastavení barvové palety, zvýšení intenzity zvolené barvové složky
000000r 1               ;
000000r 1               ; Založeno na příkladu https://github.com/depp/ctnes/tree/master/nesdev/01
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
000000r 1               
000000r 1               
000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Definice hlavičky obrazu ROM
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
000000r 1               ; Size of PRG in units of 16 KiB.
000000r 1               prg_npage = 1
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
000004r 1  01                   .byte prg_npage
000005r 1  01                   .byte chr_npage
000006r 1  01                   .byte ((mapper & $0f) << 4) | (mirroring & 1)
000007r 1  00                   .byte mapper & $f0
000008r 1               
000008r 1               
000008r 1               
000008r 1               ; ---------------------------------------------------------------------
000008r 1               ; Blok paměti s definicí dlaždic 8x8 pixelů
000008r 1               ; ---------------------------------------------------------------------
000008r 1               
000008r 1               .segment "CHR0a"
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
000000r 1  40                   rti                     ; návrat z přerušení
000001r 1               .endproc
000001r 1               
000001r 1               
000001r 1               
000001r 1               ; Obslužná rutina pro IRQ (maskovatelné přerušení)
000001r 1               
000001r 1               .proc irq
000001r 1  40                   rti                     ; návrat z přerušení
000002r 1               .endproc
000002r 1               
000002r 1               
000002r 1               
000002r 1               ; Obslužná rutina pro RESET
000002r 1               
000002r 1               .proc reset
000002r 1                       ; nastavení stavu CPU
000002r 1  78 D8 A2 FF          setup_cpu
000006r 1  9A           
000007r 1               
000007r 1                       ; nastavení řídicích registrů
000007r 1  A2 00                ldx #$00
000009r 1  8E 00 20             stx PPUCTRL             ; nastavení PPUCTRL = 0
00000Cr 1  8E 01 20             stx PPUMASK             ; nastavení PPUMASK = 0
00000Fr 1               
00000Fr 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
00000Fr 1  2C 02 20 10          wait_for_frame
000013r 1  FB           
000014r 1  2C 02 20 10          wait_for_frame
000018r 1  FB           
000019r 1               
000019r 1                       ; vymazání obsahu RAM
000019r 1  A9 00 95 00          clear_ram
00001Dr 1  9D 00 01 9D  
000021r 1  00 02 9D 00  
000025r 1  03 9D 00 04  
000029r 1  9D 00 05 9D  
00002Dr 1  00 06 9D 00  
000031r 1  07 E8 D0 E6  
000035r 1               
000035r 1                       ; čekání na další snímek
000035r 1  2C 02 20 10          wait_for_frame
000039r 1  FB           
00003Ar 1               
00003Ar 1                       ; vynulování barvové palety
00003Ar 1  AD 02 20             lda PPUSTATUS ; reset záchytného registru
00003Dr 1  A9 3F                lda #$3f      ; nastavení adresy pro barvovou paletu $3f00
00003Fr 1  8D 06 20             sta PPUADDR
000042r 1  A9 00                lda #$00      ; nižší bajt adresy
000044r 1  8D 06 20             sta PPUADDR
000047r 1               
000047r 1  A2 20                ldx #$20      ; počitadlo barev v paletě: 16+16
000049r 1  A9 00                lda #$00      ; vynulování každé barvy
00004Br 1               
00004Br 1               :
00004Br 1  8D 07 20             sta PPUDATA   ; zápis barvy
00004Er 1  CA                   dex           ; snížení hodnoty počitadla
00004Fr 1  D0 FA                bne :-
000051r 1               
000051r 1  A9 80                lda #%10000000 ; vysoká intenzita modré barvy
000053r 1  8D 01 20             sta PPUMASK
000056r 1               
000056r 1                       ; vlastní herní smyčka je prozatím prázdná
000056r 1               game_loop:
000056r 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
000059r 1               .endproc
000059r 1               
000059r 1               
000059r 1               
000059r 1               ; ---------------------------------------------------------------------
000059r 1               ; Tabulka vektorů CPU
000059r 1               ; ---------------------------------------------------------------------
000059r 1               
000059r 1               .segment "VECTORS"
000000r 1  rr rr        .addr nmi
000002r 1  rr rr        .addr reset
000004r 1  rr rr        .addr irq
000006r 1               
000006r 1               
000006r 1               
000006r 1               ; ---------------------------------------------------------------------
000006r 1               ; Finito
000006r 1               ; ---------------------------------------------------------------------
000006r 1               
