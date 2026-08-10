; %%%%%%%%%%%%%%%
; ; G device
; %%%%%%%%%%%%%%%

; Autor: (c) Milan Vančura, milan@caputu.cz
; License: CC-BY-SA
; This program is distributed with no warranty. Use on your risk.
; Note: This is a study material so, anyway, it is not intended to be used in any kind of production.

; -- show data in PMG --
; ;


.CODE

.org $9800

.byte $3F, $98, $7F, $98, $8D, $98, $B3, $98, $6E, $98, $6E, $98, $4C, $23, $99, $00 ; HATABS
.byte $10, $10, $10, $10, $1C, $2C, $6C, $AC, $90, $A4, $B8, $CC, $00, $00, $00, $00 ; read_cursors ; dev_colors ; dev_hpos
.byte $10, $10, $10, $10, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00 ; write cursors
.byte $FF, $08, $1C, $2A, $49, $08, $08, $08, $08, $08, $08, $49, $2A, $1C, $08, $FF ; visual markers

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

        ldx $21       ; IOCTL_DEVNUM
        dex           ; save devnum; normalize 1-4 to
        txa
        and #$FC
        beq devnum_ok
        ldy #$82      ; error_code "no such device"
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
        bit $2A       ; IOCTL_ICAX1
        beq test_read

        lda #$01      ; test for append mode
        bit $2A       ; IOCTL_ICAX1
        bne open_appnd
        jsr get_dev_base
        jsr init_dev_data
        lda #$10
        sta $9820,x   ; reset write_cursor
open_appnd:
        jsr show_dev
        ldy #$01      ; writing => set success

test_read:
        lda #$04
        bit $2A       ; IOCTL_ICAX1
        beq open_exit
        lda #$10
        sta $9810,x   ; reset read_cursor
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

        ldx $21
        dex
        lda #$00
        sta $D000,x
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
        lda $034A,x   ; IOCTL_ICAX1
        cmp #$09
        bne no_wr_append
        ldy #$83
        rts

no_wr_append:
        lda $0341,x
        tax
        dex
        jsr get_dev_base
        lda $9810,x   ; read_cursor
        cmp $9820,x   ; is lower then write_cursor?
        bcc read_ok
        ldy #$88      ; error: end of file
        rts

read_ok:
        tay
        lda ($CE),y
        inc $9810,x
        ldy #$01
        rts

; ============
; HATABS_PUT_CHAR
; ============
; IN:  A: the byte to write
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)
        pha
        ldy #$92      ; check RO device
        lda #$08
        bit $2A       ; IOCTL_ICAX1
        beq exit_w_error
        lda $0341,x
        tax
        dex
        jsr get_dev_base
        lda $9820,x   ; write_cursor
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
        inc $9820,x
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
        lda $9838,x
        sta ($CE),y
        dey
        dex
        bne marker_bot

        ldx #$07
        ldy #$70
marker_top:
        lda $9838,x
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
        lda $9814,x
        sta $02C0,x   ; PCOLR0-3
        lda $9818,x
        sta $D000,x   ; HPOSP0-3
        rts

; ============
; main()
; ============
; !!! contains extra PLA at the end
;     to be called from BASIC using USR()
        pha
        txa
        pha
        tya
        pha


; Add device using OS method

        ldx #$47      ; "G"
        ldy #$00
        lda #$98
        jsr $E486     ; ADD_NEWDEV
        bcs exit_init
        lda #$00

; set space in RAM and init GTIA

        sta $02E5     ; MEMTOP
        lda #$98
        sta $02E6     ; MEMTOP+1
        sta $D407     ; PMBASE
        ldx #$03
loop_init:
        jsr get_dev_base
        jsr init_dev_data
        dex
        bpl loop_init

        lda #$00
        sta $D000     ; HPOSP0
        sta $D001     ; HPOSP1
        sta $D002     ; HPOSP2
        sta $D003     ; HPOSP3
        lda #$00
        sta $026F     ; GPRIOR
        lda #$03
        sta $D01D
        lda #$2E      ; SDMCTL
        sta $022F
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
