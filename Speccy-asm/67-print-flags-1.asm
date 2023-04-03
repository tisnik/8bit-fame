ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


	org ENTRY_POINT

start:
	call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)

	ld   A, 1       ; první sčítanec
	add  A, 2       ; druhý sčítance + výsledek operace

	push AF         ; uložíme pár AF na zásobník
	pop  BC         ; obnovíme původní obsah AF ze zásobníku, ovšem nyní do BC
	ld   B, 0       ; vymažeme B (což byl obsah A), ponecháme jen C (což byl obsah F)

	call OUT_NUM_1  ; zavolání rutiny pro výpis celého čísla

	ret             ; návrat z programu do BASICu

end ENTRY_POINT
