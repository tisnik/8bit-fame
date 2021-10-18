rem Výpočet největšího společného dělitele

print "x = "
input x

print "y = "
input y

while x<>y
    if x>y then
        x=x-y
    endif
    if x<y then
        y=y-x
    endif
end while

print "gcd = "
print x
