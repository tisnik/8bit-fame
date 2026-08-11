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

; memory segment starts here
begin = $9800

.org begin

; table containing vectors to subroutines implementing CIO operations
; addresses need to be decreased by one - subroutines are called via RTS instruction!
hatabs_handler:
    .word g_open-1
    .word g_close-1
    .word g_get-1
    .word g_put-1
    .word g_nondef-1
    .word g_nondef-1
    JMP g_init
    .byte $00


cursor_low_limit = $10
cursor_top_limit = $70

; offsets that are updated during operations with devices

; read cursors for all four devices
read_cursors:
    .byte cursor_low_limit, cursor_low_limit, cursor_low_limit, cursor_low_limit

; write cursors for all four devices
write_cursors:
    .byte cursor_low_limit, cursor_low_limit, cursor_low_limit, cursor_low_limit

; colors assigned to all four sprites (one per device)
dev_colors:
    .byte $1C, $2C, $6C, $AC
 
; horizontal positions for all four sprites (one per device)
dev_hpos:
    .byte $90, $A4, $B8, $CC

visual_markers:
    .byte $08, $08, $08, $49, $2A, $1C, $08, $FF

; address of two bytes allocated on zero page:
; $CE, $CF    ; cur_base_l :L,:H
cur_base_l = $ce
cur_base_h = cur_base_l + 1
; the following address will be used in the code
cur_base = cur_base_l


; ============
; HATABS_OPEN
; ============
; IN: ---
; OUT: Y: 01 = success
;        >80 = error

; check device number, we support G1 - G4 only
g_open:
        ldx ICDNOZ
        dex           ; save devnum; normalize 1-4 to 0-3
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
; any    some operation => success (LDY #SUCCES)

devnum_ok:
        ldy #NVALID   ; error_code "invalid command"
        lda #$F2
        bit ICAX1Z
        bne open_exit ; throw the error
        lda #$08
        bit ICAX1Z
        beq test_read

        lda #$01      ; test for append mode
        bit ICAX1Z
        bne open_appnd
        jsr get_dev_base
        jsr init_dev_data
        lda #cursor_low_limit
        sta write_cursors, x  ; reset write_cursor
open_appnd:
        jsr show_dev
        ldy #SUCCES      ; writing => set success

test_read:
        lda #$04
        bit ICAX1Z
        beq open_exit
        lda #cursor_low_limit
        sta read_cursors, x  ; reset read_cursor
        jsr show_dev
g_nondef:
        ldy #SUCCES
open_exit:
        rts


; ============
; HATABS_CLOSE
; ============
; IN: ---
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)

g_close:
        ldx ICDNOZ
        dex
        lda #$00
        sta HPOSP0, x    ; move sprite off the screen
        ldy #SUCCES
        rts

; ============
; HATABS_GET_CHAR
; ============
; IN:  X - channel number * $10
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)
;      A: the byte read
g_get:
        lda ICAX1, x
        cmp #$09
        bne no_wr_append
        ldy #WRONLY   ; error_code "attempted to read a write-only device"
        rts

no_wr_append:
        lda ICDNO, x
        tax
        dex           ; dev number 0-3 to X
        jsr get_dev_base
        lda read_cursors, x   ; read_cursor
        cmp write_cursors, x  ; is lower then write_cursor?
        bcc read_ok
        ldy #EOFERR      ; error_code "end of file"
        rts

read_ok:
        tay
        lda (cur_base), y     ; read byte from the device
        inc read_cursors, x
        ldy #SUCCES
        rts

; ============
; HATABS_PUT_CHAR
; ============
; IN:  A: the byte to write
; OUT: Y: 01 = success
;        >80 = error (see the CIO err_code list)
g_put:
        pha
        ldy #FNCNOT   ; error_code "function not implemented in handler"
        lda #$08
        bit ICAX1Z    ; throw the error
        beq exit_w_error
        lda ICDNO, x
        tax
        dex                        ; dev number 0-3 to X
        jsr get_dev_base
        lda write_cursors, x
        cmp #cursor_top_limit      ; still a space in the buff?
        bcc write_ok
        ldy #EOFERR   ; error_code "end of file"
exit_w_error:
        pla
        rts

write_ok:
        tay
        pla
        sta (cur_base),y          ; store the byte in the device
        inc write_cursors, x
        ldy #SUCCES
        rts


; ============
; Get Device Base Address
; ============
; IN:   X: device num (0-3)
; OUT:  $CE, $CF: current device base :L,:H
get_dev_base:
        lda #>begin+2      ; PMBASE + 2
        sta cur_base_h
        ldy #$00
        txa
        lsr
        bcc dev02
        ldy #$80
dev02:
        sty cur_base_l
        lsr
        bcc dev01
        inc cur_base_h
dev01:
        rts

; ============
; Init Device Data
; ============
; IN:   cur_base must be set
; OUT:  device data cleared + markers drawn
init_dev_data:
        ldy #$80
        lda #$00
null_loop:
        dey
        sta (cur_base),y
        bne null_loop
        txa
        pha
        ldx #$07	; draw visual markers - top
        ldy #$0F
marker_bot:
        lda visual_markers, x
        sta (cur_base),y
        dey
        dex
        bne marker_bot

        ldx #$07	; draw visual markers - bottom
        ldy #$70
marker_top:
        lda visual_markers, x
        sta (cur_base),y
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
        sta PCOLR0, x
        lda dev_hpos, x
        sta HPOSP0, x
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

        ldx #'G'      ; device name
        ldy #<hatabs_handler
        lda #>hatabs_handler
        jsr PHENTV    ; ADD_NEWDEV
        bcs exit_init

; set space in RAM and init GTIA

        lda #<begin
        sta MEMTOP
        lda #>begin
        sta MEMTOP+1

        sta PMBASE
        ldx #$03          ; init all devices data
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
        lda #$01
        sta GPRIOR
        lda #$03    ; enable sprites
        sta GRACTL
        lda #$2E    ; enable DMA for display list and sprites, set normal playfield width
        sta SDMCTL
exit_init:
        pla
        tay
        pla
        tax
        pla
        pla
        rts

end:

.segment "EXEHDR"
.word   $ffff                   ; uvodni sekvence bajtu v souboru XEX
.word   begin                   ; zacatek kodoveho segmentu
.word   end                     ; konec kodoveho segmentu

; finito
