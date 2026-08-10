ca65 V2.18 - Fedora 2.19-12.fc42
Main file   : g_device.asm
Current file: g_device.asm

000000r 1               ; %%%%%%%%%%%%%%%
000000r 1               ; ; G device
000000r 1               ; %%%%%%%%%%%%%%%
000000r 1               
000000r 1               ; Autor: (c) Milan Vančura, milan@caputu.cz
000000r 1               ; License: CC-BY-SA
000000r 1               ; This program is distributed with no warranty. Use on your risk.
000000r 1               ; Note: This is a study material so, anyway, it is not intended to be used in any kind of production.
000000r 1               
000000r 1               ; -- show data in PMG --
000000r 1               ; ;
000000r 1               
000000r 1               
000000r 1               .CODE
000000r 1               
000000r 1               .org $9800
009800  1               
009800  1  3F 98 7F 98  .byte $3F, $98, $7F, $98, $8D, $98, $B3, $98, $6E, $98, $6E, $98, $4C, $23, $99, $00 ; HATABS
009804  1  8D 98 B3 98  
009808  1  6E 98 6E 98  
00980C  1  4C 23 99 00  
009810  1  10 10 10 10  .byte $10, $10, $10, $10, $1C, $2C, $6C, $AC, $90, $A4, $B8, $CC, $00, $00, $00, $00 ; read_cursors ; dev_colors ; dev_hpos
009814  1  1C 2C 6C AC  
009818  1  90 A4 B8 CC  
00981C  1  00 00 00 00  
009820  1  10 10 10 10  .byte $10, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; write cursors
009824  1  00 00 00 00  
009828  1  00 00 00 00  
00982C  1  00 00 00 00  
009830  1  FF 08 1C 2A  .byte $FF, $08, $1C, $2A, $49, $08, $08, $08, $08, $08, $08, $49, $2A, $1C, $08, $FF ; visual markers
009834  1  49 08 08 08  
009838  1  08 08 08 49  
00983C  1  2A 1C 08 FF  
009840  1               
009840  1               ; START = $9840
009840  1               
009840  1               ; zero page:
009840  1               ; $CE, $CF    ; cur_base :L,:H
009840  1               
009840  1               ; ============
009840  1               ; HATABS_OPEN
009840  1               ; ============
009840  1               ; IN: ---
009840  1               ; OUT: Y: 01 = success
009840  1               ;        >80 = error (see the CIO err_code list)
009840  1               
009840  1               ; check device number, we support G1 - G4 only
009840  1               
009840  1  A6 21                ldx $21       ; IOCTL_DEVNUM
009842  1  CA                   dex           ; save devnum; normalize 1-4 to
009843  1  8A                   txa
009844  1  29 FC                and #$FC
009846  1  F0 03                beq devnum_ok
009848  1  A0 82                ldy #$82      ; error_code "no such device"
00984A  1  60                   rts
00984B  1               
00984B  1               ; init the device in the command code, we support only (4,8,9,12,13)
00984B  1               ; Binary Flags:
00984B  1               ;   1    append (together with 8 only) => skip buffer cleanup and skip W cursor reset
00984B  1               ;   4    reading => set read cursor, show device
00984B  1               ;   8    writing => buffer cleanup, W cursor reset, show device
00984B  1               ; any    some operation => success (LDY #$01)
00984B  1               
00984B  1               devnum_ok:
00984B  1  A0 84                ldy #$84
00984D  1  A9 F2                lda #$F2
00984F  1  24 2A                bit $2A       ; err: unsupported operation
009851  1  D0 2C                bne open_exit
009853  1  A9 08                lda #$08
009855  1  24 2A                bit $2A       ; IOCTL_ICAX1
009857  1  F0 16                beq test_read
009859  1               
009859  1  A9 01                lda #$01      ; test for append mode
00985B  1  24 2A                bit $2A       ; IOCTL_ICAX1
00985D  1  D0 0B                bne open_appnd
00985F  1  20 DA 98             jsr get_dev_base
009862  1  20 EE 98             jsr init_dev_data
009865  1  A9 10                lda #$10
009867  1  9D 20 98             sta $9820,x   ; reset write_cursor
00986A  1               open_appnd:
00986A  1  20 16 99             jsr show_dev
00986D  1  A0 01                ldy #$01      ; writing => set success
00986F  1               
00986F  1               test_read:
00986F  1  A9 04                lda #$04
009871  1  24 2A                bit $2A       ; IOCTL_ICAX1
009873  1  F0 0A                beq open_exit
009875  1  A9 10                lda #$10
009877  1  9D 10 98             sta $9810,x   ; reset read_cursor
00987A  1  20 16 99             jsr show_dev
00987D  1  A0 01                ldy #$01
00987F  1               open_exit:
00987F  1  60                   rts
009880  1               
009880  1               
009880  1               ; ============
009880  1               ; HATABS_CLOSE
009880  1               ; ============
009880  1               ; IN: ---
009880  1               ; OUT: Y: 01 = success
009880  1               ;        >80 = error (see the CIO err_code list)
009880  1               
009880  1  A6 21                ldx $21
009882  1  CA                   dex
009883  1  A9 00                lda #$00
009885  1  9D 00 D0             sta $D000,x
009888  1  20 DA 98             jsr get_dev_base
00988B  1  A0 01                ldy #$01
00988D  1  60                   rts
00988E  1               
00988E  1               ; ============
00988E  1               ; HATABS_GET_CHAR
00988E  1               ; ============
00988E  1               ; IN: ---
00988E  1               ; OUT: Y: 01 = success
00988E  1               ;        >80 = error (see the CIO err_code list)
00988E  1               ;      A: the byte read
00988E  1  BD 4A 03             lda $034A,x   ; IOCTL_ICAX1
009891  1  C9 09                cmp #$09
009893  1  D0 03                bne no_wr_append
009895  1  A0 83                ldy #$83
009897  1  60                   rts
009898  1               
009898  1               no_wr_append:
009898  1  BD 41 03             lda $0341,x
00989B  1  AA                   tax
00989C  1  CA                   dex
00989D  1  20 DA 98             jsr get_dev_base
0098A0  1  BD 10 98             lda $9810,x   ; read_cursor
0098A3  1  DD 20 98             cmp $9820,x   ; is lower then write_cursor?
0098A6  1  90 03                bcc read_ok
0098A8  1  A0 88                ldy #$88      ; error: end of file
0098AA  1  60                   rts
0098AB  1               
0098AB  1               read_ok:
0098AB  1  A8                   tay
0098AC  1  B1 CE                lda ($CE),y
0098AE  1  FE 10 98             inc $9810,x
0098B1  1  A0 01                ldy #$01
0098B3  1  60                   rts
0098B4  1               
0098B4  1               ; ============
0098B4  1               ; HATABS_PUT_CHAR
0098B4  1               ; ============
0098B4  1               ; IN:  A: the byte to write
0098B4  1               ; OUT: Y: 01 = success
0098B4  1               ;        >80 = error (see the CIO err_code list)
0098B4  1  48                   pha
0098B5  1  A0 92                ldy #$92      ; check RO device
0098B7  1  A9 08                lda #$08
0098B9  1  24 2A                bit $2A       ; IOCTL_ICAX1
0098BB  1  F0 11                beq exit_w_error
0098BD  1  BD 41 03             lda $0341,x
0098C0  1  AA                   tax
0098C1  1  CA                   dex
0098C2  1  20 DA 98             jsr get_dev_base
0098C5  1  BD 20 98             lda $9820,x   ; write_cursor
0098C8  1  C9 70                cmp #$70      ; still a space in the buff?
0098CA  1  90 04                bcc write_ok
0098CC  1  A0 88                ldy #$88      ; error: end of file
0098CE  1               exit_w_error:
0098CE  1  68                   pla
0098CF  1  60                   rts
0098D0  1               
0098D0  1               write_ok:
0098D0  1  A8                   tay
0098D1  1  68                   pla
0098D2  1  91 CE                sta ($CE),y
0098D4  1  FE 20 98             inc $9820,x
0098D7  1  A0 01                ldy #$01
0098D9  1  60                   rts
0098DA  1               
0098DA  1               
0098DA  1               ; ============
0098DA  1               ; Get Device Base Address
0098DA  1               ; ============
0098DA  1               ; IN:   X: device num (0-3)
0098DA  1               ; OUT:  $CE, $CF: current device base :L,:H
0098DA  1               get_dev_base:
0098DA  1  A9 9A                lda #$9A      ; PMBASE + 2 ; L: get_dev_base
0098DC  1  85 CF                sta $CF
0098DE  1  A0 00                ldy #$00
0098E0  1  8A                   txa
0098E1  1  4A                   lsr
0098E2  1  90 02                bcc dev02
0098E4  1  A0 80                ldy #$80
0098E6  1               dev02:
0098E6  1  84 CE                sty $CE
0098E8  1  4A                   lsr
0098E9  1  90 02                bcc dev01
0098EB  1  E6 CF                inc $CF
0098ED  1               dev01:
0098ED  1  60                   rts
0098EE  1               
0098EE  1               ; ============
0098EE  1               ; Init Device Data
0098EE  1               ; ============
0098EE  1               ; IN:   $CE, $CF: current device base :L,:H
0098EE  1               ; OUT:  device data cleared + markers drawn
0098EE  1               init_dev_data:
0098EE  1  A0 80                ldy #$80
0098F0  1  A9 00                lda #$00
0098F2  1               null_loop:
0098F2  1  88                   dey
0098F3  1  91 CE                sta ($CE),y
0098F5  1  D0 FB                bne null_loop
0098F7  1               
0098F7  1  8A                   txa
0098F8  1  48                   pha
0098F9  1  A2 07                ldx #$07
0098FB  1  A0 0F                ldy #$0F
0098FD  1               marker_bot:
0098FD  1  BD 38 98             lda $9838,x
009900  1  91 CE                sta ($CE),y
009902  1  88                   dey
009903  1  CA                   dex
009904  1  D0 F7                bne marker_bot
009906  1               
009906  1  A2 07                ldx #$07
009908  1  A0 70                ldy #$70
00990A  1               marker_top:
00990A  1  BD 38 98             lda $9838,x
00990D  1  91 CE                sta ($CE),y
00990F  1  C8                   iny
009910  1  CA                   dex
009911  1  D0 F7                bne marker_top
009913  1               
009913  1  68                   pla
009914  1  AA                   tax
009915  1  60                   rts
009916  1               
009916  1               ; ============
009916  1               ; Show Device on the Screen
009916  1               ; ============
009916  1               ; IN:   X: device num (0-3)
009916  1               ; OUT:  ---
009916  1               ; Show Device on the Screen
009916  1               show_dev:
009916  1  BD 14 98             lda $9814,x
009919  1  9D C0 02             sta $02C0,x   ; PCOLR0-3
00991C  1  BD 18 98             lda $9818,x
00991F  1  9D 00 D0             sta $D000,x   ; HPOSP0-3
009922  1  60                   rts
009923  1               
009923  1               ; ============
009923  1               ; main()
009923  1               ; ============
009923  1               ; !!! contains extra PLA at the end
009923  1               ;     to be called from BASIC using USR()
009923  1  48                   pha
009924  1  8A                   txa
009925  1  48                   pha
009926  1  98                   tya
009927  1  48                   pha
009928  1               
009928  1               
009928  1               ; Add device using OS method
009928  1               
009928  1  A2 47                ldx #$47      ; "G"
00992A  1  A0 00                ldy #$00
00992C  1  A9 98                lda #$98
00992E  1  20 86 E4             jsr $E486     ; ADD_NEWDEV
009931  1  B0 35                bcs exit_init
009933  1  A9 00                lda #$00
009935  1               
009935  1               ; set space in RAM and init GTIA
009935  1               
009935  1  8D E5 02             sta $02E5     ; MEMTOP
009938  1  A9 98                lda #$98
00993A  1  8D E6 02             sta $02E6     ; MEMTOP+1
00993D  1  8D 07 D4             sta $D407     ; PMBASE
009940  1  A2 03                ldx #$03
009942  1               loop_init:
009942  1  20 DA 98             jsr get_dev_base
009945  1  20 EE 98             jsr init_dev_data
009948  1  CA                   dex
009949  1  10 F7                bpl loop_init
00994B  1               
00994B  1  A9 00                lda #$00
00994D  1  8D 00 D0             sta $D000     ; HPOSP0
009950  1  8D 01 D0             sta $D001     ; HPOSP1
009953  1  8D 02 D0             sta $D002     ; HPOSP2
009956  1  8D 03 D0             sta $D003     ; HPOSP3
009959  1  A9 00                lda #$00
00995B  1  8D 6F 02             sta $026F     ; GPRIOR
00995E  1  A9 03                lda #$03
009960  1  8D 1D D0             sta $D01D
009963  1  A9 2E                lda #$2E      ; SDMCTL
009965  1  8D 2F 02             sta $022F
009968  1               exit_init:
009968  1  68                   pla
009969  1  A8                   tay
00996A  1  68                   pla
00996B  1  AA                   tax
00996C  1  68                   pla
00996D  1  68                   pla
00996E  1  60                   rts
00996F  1               
00996F  1  00                   brk
009970  1               end:
009970  1               
009970  1               .segment "EXEHDR"
009970  1  FF FF        .word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
009972  1  00 98        .word   $9800                   ; zacatek kodoveho segmentu
009974  1  6F 99        .word   $996f                   ; konec kodoveho segmentu
009976  1               
009976  1               ; finito
009976  1               
