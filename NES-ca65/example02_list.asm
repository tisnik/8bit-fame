ca65 V2.18 - Ubuntu 2.18-1
Main file   : example02.asm
Current file: example02.asm

000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Neoptimalizovaná kostra programu pro herní konzoli NES
000000r 1               ; Použití standardního nastavení segmentů podle ca65 (cc65)
000000r 1               ;
000000r 1               ; Založeno na příkladu https://github.com/depp/ctnes/tree/master/nesdev/01
000000r 1               ; Viz též článek na https://www.moria.us/blog/2018/03/nes-development
000000r 1               ; ---------------------------------------------------------------------
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
000008r 1               ; ---------------------------------------------------------------------
000008r 1               ; Blok paměti s definicí dlaždic 8x8 pixelů
000008r 1               ; ---------------------------------------------------------------------
000008r 1               
000008r 1               .segment "CHARS"
000000r 1               
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
000002r 1  78                   sei                     ; zákaz přerušení
000003r 1  D8                   cld                     ; vypnutí dekadického režimu (není podporován)
000004r 1               
000004r 1  A2 FF                ldx #$ff
000006r 1  9A                   txs                     ; vrchol zásobníku nastaven na 0xff (první stránka)
000007r 1               
000007r 1                       ; nastavení řídicích registrů
000007r 1  A2 00                ldx #$00
000009r 1  8E 00 20             stx $2000               ; nastavení PPUCTRL = 0
00000Cr 1  8E 01 20             stx $2001               ; nastavení PPUMASK = 0
00000Fr 1  8E 15 40             stx $4015               ; nastavení APUSTATUS = 0
000012r 1               
000012r 1                       ; čekání na vnitřní inicializaci PPU (dva snímky)
000012r 1  2C 02 20     wait1:  bit $2002               ; test obsahu registru PPUSTATUS
000015r 1  10 FB                bpl wait1               ; skok, pokud je příznak N nulový
000017r 1  2C 02 20     wait2:  bit $2002               ; test obsahu registru PPUSTATUS
00001Ar 1  10 FB                bpl wait2               ; skok, pokud je příznak N nulový
00001Cr 1               
00001Cr 1                       ; vymazání obsahu RAM
00001Cr 1  A9 00                lda #$00                ; vynulování registru A
00001Er 1  95 00        loop:   sta $000, x             ; vynulování X-tého bajtu v nulté stránce
000020r 1  9D 00 01             sta $100, x
000023r 1  9D 00 02             sta $200, x
000026r 1  9D 00 03             sta $300, x
000029r 1  9D 00 04             sta $400, x
00002Cr 1  9D 00 05             sta $500, x
00002Fr 1  9D 00 06             sta $600, x
000032r 1  9D 00 07             sta $700, x             ; vynulování X-tého bajtu v sedmé stránce
000035r 1  E8                   inx                     ; přechod na další bajt
000036r 1  D0 E6                bne loop                ; po přetečení 0xff -> 0x00 konec smyčky
000038r 1               
000038r 1                       ; čekání na dokončení dalšího snímku, potom může začít herní smyčka
000038r 1  2C 02 20     wait3:  bit $2002               ; test obsahu registru PPUSTATUS
00003Br 1  10 FB                bpl wait3               ; skok, pokud je příznak N nulový
00003Dr 1               
00003Dr 1                       ; vlastní herní smyčka je prozatím prázdná
00003Dr 1               game_loop:
00003Dr 1  4C rr rr             jmp game_loop           ; nekonečná smyčka (později rozšíříme)
000040r 1               .endproc
000040r 1               
000040r 1               
000040r 1               
000040r 1               ; ---------------------------------------------------------------------
000040r 1               ; Tabulka vektorů CPU
000040r 1               ; ---------------------------------------------------------------------
000040r 1               
000040r 1               .segment "VECTORS"
000000r 1  rr rr        .addr nmi
000002r 1  rr rr        .addr reset
000004r 1  rr rr        .addr irq
000006r 1               
000006r 1               
000006r 1               
000006r 1               .segment "STARTUP"
000000r 1               
000000r 1               ; ---------------------------------------------------------------------
000000r 1               ; Finito
000000r 1               ; ---------------------------------------------------------------------
000000r 1               
