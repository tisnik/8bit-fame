rem Rozhodovací konstrukce if-then
rem Vnořené příkazy if-then

print "x = "
input x

if x < 0 then
    print "Negative value"
else
    if x > 0 then
        print "Positive value"
    else
        print "Zero"
    endif
endif
