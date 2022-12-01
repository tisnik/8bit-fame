REM *****************************
REM 
REM Operace se s vice zaznamy.
REM 
REM Uprava pro BaCon
REM 
REM *****************************

RECORD users[10]
    LOCAL id
    LOCAL name$
    LOCAL surname$
END RECORD

users[0].id = 0
users[0].name$ = "Linus"
users[0].surname$ = "Torvalds"

users[1].id = 1
users[1].name$ = "Ken"
users[1].surname$ = "Iverson"

users[2].id = 2
users[2].name$ = "Rob"
users[2].surname$ = "Pike"

FOR i=0 TO 2
    PRINT users[i].id, " ", users[i].name$, " ", users[i].surname$
NEXT i
