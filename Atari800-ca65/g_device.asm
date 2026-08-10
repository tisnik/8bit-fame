; %%%%%%%%%%%%%%%
; ; G device
; %%%%%%%%%%%%%%%

; Autor: (c) Milan Vančura, milan@caputu.cz
; License: CC-BY-SA
; This program is distributed with no warranty. Use on your risk.
; Note: This is a study material so, anyway, it is not intended to be used in any kind of production.

; -- show data in PMG --
; ;

.include "atari.inc"

.CODE

.org $9800

hatabs_handler:
    .word g_open-1
    .word g_close-1
    .word g_get-1
    .word g_put-1
    .word g_nondef-1
    .word g_nondef-1
    JMP g_init
    .byte $00

read_cursors:
    .byte $10, $10, $10, $10

dev_colors:
    .byte $1C, $2C, $6C, $AC
 
dev_hpos:
    .byte $90, $A4, $B8, $CC, $00, $00, $00, $00

write_cursors:
    .byte $10, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    .byte $FF, $08, $1C, $2A, $49, $08, $08, $08

visual_markers:
    .byte $08, $08, $08, $49, $2A, $1C, $08, $FF

; START = $9840

; zero page:
; $CE, $CF    ; cur_base :L,:H

; ============
; HATABS_OPEN
; ============
; IN: ---
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)

; check device number, we support G1 - G4 only
g_open:
        ldx ICDNOZ    ; IOCTL_DEVNUM
        dex           ; save devnum; normalize 1-4 to
        txa
        and #$FC
        beq devnum_ok
        ldy #NONDEV   ; error_code "no such device"
        rts

; init the device in the command code, we support only (4,8,9,12,13)
; Binary Flags:
;   1    append (together with 8 only) => skip buffer cleanup and skip W cursor reset
;   4    reading => set read cursor, show device
;   8    writing => buffer cleanup, W cursor reset, show device
; any    some operation => success (LDY #$01)

devnum_ok:
        ldy #$84
        lda #$F2
        bit $2A       ; err: unsupported operation
        bne open_exit
        lda #$08
        bit ICAX1Z    ; IOCTL_ICAX1
        beq test_read

        lda #$01      ; test for append mode
        bit ICAX1Z    ; IOCTL_ICAX1
        bne open_appnd
        jsr get_dev_base
        jsr init_dev_data
        lda #$10
        sta write_cursors, x  ; reset write_cursor
open_appnd:
        jsr show_dev
        ldy #$01      ; writing => set success

g_nondef:
test_read:
        lda #$04
        bit ICAX1Z    ; IOCTL_ICAX1
        beq open_exit
        lda #$10
        sta read_cursors, x  ; reset read_cursor
        jsr show_dev
        ldy #$01
open_exit:
        rts


; ============
; HATABS_CLOSE
; ============
; IN: ---
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)

g_close:
        ldx $21
        dex
        lda #$00
        sta HPOSP0, x
        jsr get_dev_base
        ldy #$01
        rts

; ============
; HATABS_GET_CHAR
; ============
; IN: ---
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)
;      A: the byte read
g_get:
        lda ICAX1, x   ; IOCTL_ICAX1
        cmp #$09
        bne no_wr_append
        ldy #$83
        rts

no_wr_append:
        lda ICDNO, x
        tax
        dex
        jsr get_dev_base
        lda read_cursors, x   ; read_cursor
        cmp write_cursors, x  ; is lower then write_cursor?
        bcc read_ok
        ldy #$88      ; error: end of file
        rts

read_ok:
        tay
        lda ($CE), y
        inc read_cursors, x
        ldy #$01
        rts

; ============
; HATABS_PUT_CHAR
; ============
; IN:  A: the byte to write
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)
g_put:
        pha
        ldy #$92      ; check RO device
        lda #$08
        bit $2A       ; IOCTL_ICAX1
        beq exit_w_error
        lda ICDNO, x
        tax
        dex
        jsr get_dev_base
        lda write_cursors, x
        cmp #$70      ; still a space in the buff?
        bcc write_ok
        ldy #$88      ; error: end of file
exit_w_error:
        pla
        rts

write_ok:
        tay
        pla
        sta ($CE),y
        inc write_cursors, x
        ldy #$01
        rts


; ============
; Get Device Base Address
; ============
; IN:   X: device num (0-3)
; OUT:  $CE, $CF: current device base :L,:H
get_dev_base:
        lda #$9A      ; PMBASE + 2 ; L: get_dev_base
        sta $CF
        ldy #$00
        txa
        lsr
        bcc dev02
        ldy #$80
dev02:
        sty $CE
        lsr
        bcc dev01
        inc $CF
dev01:
        rts

; ============
; Init Device Data
; ============
; IN:   $CE, $CF: current device base :L,:H
; OUT:  device data cleared + markers drawn
init_dev_data:
        ldy #$80
        lda #$00
null_loop:
        dey
        sta ($CE),y
        bne null_loop
        txa
        pha
        ldx #$07
        ldy #$0F
marker_bot:
        lda visual_markers, x
        sta ($CE),y
        dey
        dex
        bne marker_bot

        ldx #$07
        ldy #$70
marker_top:
        lda visual_markers, x
        sta ($CE),y
        iny
        dex
        bne marker_top

        pla
        tax
        rts

; ============
; Show Device on the Screen
; ============
; IN:   X: device num (0-3)
; OUT:  ---
; Show Device on the Screen
show_dev:
        lda dev_colors, x
        sta PCOLR0, x   ; PCOLR0-PCOL3
        lda dev_hpos, x
        sta HPOSP0, x   ; HPOSP0-HPOSP3
        rts

; ============
; main()
; ============
; !!! contains extra PLA at the end
;     to be called from BASIC using USR()
g_init:
        pha
        txa
        pha
        tya
        pha


; Add device using OS method

        ldx #$47      ; "G"
        ldy #$00
        lda #$98
        jsr PHENTV    ; ADD_NEWDEV
        bcs exit_init
        lda #$00

; set space in RAM and init GTIA

        sta MEMTOP
        lda #$98
        sta MEMTOP+1
        sta PMBASE
        ldx #$03
loop_init:
        jsr get_dev_base
        jsr init_dev_data
        dex
        bpl loop_init

        lda #$00
        sta HPOSP0
        sta HPOSP1
        sta HPOSP2
        sta HPOSP3
        lda #$00
        sta GPRIOR
        lda #$03
        sta $D01D
        lda #$2E
        sta SDMCTL
exit_init:
        pla
        tay
        pla
        tax
        pla
        pla
        rts

        brk
end:

.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   $9800                   ; zacatek kodoveho segmentu
.word   $996f                   ; konec kodoveho segmentu

; finito
