;
; File generated by cc65 v 2.18 - Ubuntu 2.18-1
;
	.fopt		compiler,"cc65 v 2.18 - Ubuntu 2.18-1"
	.setcpu		"6502"
	.smart		on
	.autoimport	on
	.case		on
	.debuginfo	off
	.importzp	sp, sreg, regsave, regbank
	.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4
	.macpack	longbranch
	.forceimport	__STARTUP__
	.export		_main

; ---------------------------------------------------------------
; void __near__ main (void)
; ---------------------------------------------------------------

.segment	"CODE"

.proc	_main: near

.segment	"BSS"

L0002:
	.res	1,$00
L0003:
	.res	1,$00
L0004:
	.res	1,$00

.segment	"CODE"

;
; a = 10;
;
	lda     #$0A
	sta     L0002
;
; b = 20;
;
	lda     #$14
	sta     L0003
;
; c = a + b;
;
	ldx     #$00
	lda     L0002
	bpl     L000B
	dex
L000B:	sta     ptr1
	stx     ptr1+1
	ldx     #$00
	lda     L0003
	bpl     L000C
	dex
L000C:	clc
	adc     ptr1
	pha
	txa
	adc     ptr1+1
	pla
	cmp     #$80
	sta     L0004
;
; }
;
	rts

.endproc
