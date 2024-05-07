rem *****************************
rem
rem Data jako součást zdrojového
rem kódu
rem 
rem Úprava pro EndBASIC
rem
rem *****************************



for j = 1 to 5
    restore
    for i = 1 to 3
        read a$
        print a$
    next
next

data "FOO", "BAR", "BAZ"
