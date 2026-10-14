n=0

proc factorial
    fact%=1.0
    for i=n to 1 step -1
        fact%=fact%*i
    next i
    print fact%
endproc

for n=1 to 20
    @factorial
next n

do
loop

