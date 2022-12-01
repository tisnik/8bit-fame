REM *****************************
REM 
REM Operace s asociativnim polem.
REM 
REM Uprava pro BaCon
REM 
REM *****************************

DECLARE map$ ASSOC STRING

map$("foo") = "FOO"
map$("bar") = "BAR"
map$("baz") = ""

PRINT map$("foo")
PRINT map$("bar")
PRINT map$("baz")
PRINT map$("xyzzy")
