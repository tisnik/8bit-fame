; Example that is used in following article:
;    Aritmetické operace s hodnotami uloženými binárně i ve formátu BCD
;    https://www.root.cz/clanky/aritmeticke-operace-s-hodnotami-ulozenymi-binarne-i-ve-formatu-bcd/
;
; This article is part of series:
;    "Vývoj pro slavné ZX Spectrum"
;    https://www.root.cz/serialy/vyvoj-pro-slavne-zx-spectrum/
;
; Repository:
;    https://github.com/tisnik/8bit-fame
;
; Example #77:
;    Add numbers and print results in hexadecimal format.
;
; This source code is available at:
;    https://github.com/tisnik/8bit-fame/blob/master/Speccy-asm/77-add-hex-numbers.asm



ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


        org ENTRY_POINT

start:
        call ROM_CLS           ; smazání obrazovky a otevření kanálu číslo 2 (screen)

        ld   HL, array1        ; vytištění 11 hodnot z pole array1 v hexadecimálním formátu
        ld   B, 11
        call print_numbers

        ld   HL, array2        ; vytištění 11 hodnot z pole array2 v hexadecimálním formátu
        ld   B, 11
        call print_numbers

        call new_line          ; odřádkování
        call new_line          ; (chyba v ROM subrutině nebo užitečná vlastnost?)

        ld   DE, array1        ; adresa pole s první řadou sčítanců
        ld   HL, array2        ; adresa pole se druhou řadou sčítanců
        ld   B, 11
next_add:
        ld   A, (DE)           ; načíst první sčítanec z pole
        add  A, (HL)           ; načíst druhý sčítanec z pole
        inc  DE                ; posun ukazatele na další sčítanec
        inc  HL                ; dtto
        call print_hex_number  ; vytisknout hexa hodnotu výsledku
        call space
        djnz next_add          ; kontrola počtu zobrazených výsledků
        ret

; podprogram pro tisk sekvence numerických hodnot v hexadecimálním formátu
; vstupy:
;         HL - ukazatel na pole s hodnotami
;         B - počet hodnot (délka pole)
print_numbers:
next_item:
        ld   A, (HL)           ; načíst hodnotu z pole
        inc  HL                ; přechod na další prvek pole
        call print_hex_number  ; vytisknout hexa hodnotu
        ld   A, B
        cp   1                 ; za poslední hodnotou už nechceme tisknout mezeru
        jr   Z, skip           ; přeskočení tisku mezery u poslední hodnoty
        call space
skip:
        djnz next_item         ; zpracování dalšího prvku pole
        ret

array1:
        db 0x00, 0x01, 0x05, 0x09, 0x09, 0x09, 0x10, 0x10, 0xa0, 0xfe, 0xff

array2:
        db 0x01, 0x02, 0x05, 0x01, 0x06, 0x07, 0x09, 0x10, 0x01, 0x01, 0x01


print_hex_number:
        push AF             ; uschovat A pro pozdější využití
        rrca                ; rotace o čtyři bity doprava
        rrca
        rrca
        rrca
        and  $0f            ; zamaskovat horní čtyři bity
        call print_hex_digit; vytisknout hexa číslici

        pop  AF             ; obnovit A
        and  $0f            ; zamaskovat horní čtyři bity
        jp print_hex_digit  ; vytisknout hexa číslici a návrat z podprogramu

print_hex_digit:
        cp   0x0a           ; test, jestli je číslice menší než 10
        jr c, print_0_to_9  ; ok, hodnota je menší než 10, budeme tedy tisknout desítkovou číslici
        add  A, 65-10-48    ; ASCII kód znaku 'A', ovšem začínáme od desítky, ne od nuly (+ update pro další ADD)
print_0_to_9:
        add  A, 48          ; ASCII kód znaku '0'
        rst  0x10           ; zavolání rutiny v ROM pro tisk jednoho znaku
        ret                 ; návrat ze subrutiny

new_line:
        ld   A, 0x0d        ; kód znaku pro odřádkování
        rst  0x10           ; zavolání rutiny v ROM
        ret                 ; návrat ze subrutiny

space:
        ld   A, 32          ; kód mezery
        rst  0x10           ; zavolání rutiny v ROM
        ret                 ; návrat ze subrutiny


end ENTRY_POINT
