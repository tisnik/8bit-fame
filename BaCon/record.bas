REM *****************************
REM 
REM Operace se zaznamem.
REM 
REM Uprava pro BaCon
REM 
REM *****************************

RECORD user
    LOCAL id
    LOCAL name$
    LOCAL surname$
END RECORD

user.id = 42
user.name$ = "Linus"
user.surname$ = "Torvalds"

PRINT user.id, " ", user.name$, " ", user.surname$
