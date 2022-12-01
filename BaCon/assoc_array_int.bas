REM *****************************
REM 
REM Operace s asociativnim polem.
REM 
REM Uprava pro BaCon
REM 
REM *****************************

DECLARE map ASSOC int

map("foo") = 1
map("bar") = 42
map("baz") = -1

PRINT map("foo")
PRINT map("bar")
PRINT map("baz")
PRINT map("xyzzy")
