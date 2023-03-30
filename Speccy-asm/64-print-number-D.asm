ENTRY_POINT   equ $8000
ROM_CLS       equ $0DAF
OUT_NUM_1     equ $1A1B


	org ENTRY_POINT

start:
	call ROM_CLS    ; smazání obrazovky a otevření kanálu číslo 2 (screen)
	ld   BC, 10000  ; numerická hodnota, kterou chceme vytisknout
	call OUT_NUM_1  ; zavolání rutiny pro výpis celého čísla
	ret             ; návrat z programu do BASICu

end ENTRY_POINT
