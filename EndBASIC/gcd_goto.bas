rem *****************************
rem
rem Výpočet největšího společného
rem dělitele.
rem 
rem Úprava pro EndBASIC
rem (využití GOTO)
rem 
rem *****************************



print "x=";
input x
print "y=";
input y
rem "Vypocet"

@loop
if x=y then
    print "gcd:"; x
end if
if x>y then
    x=x-y
    goto @loop
end if
if x<y then
    y=y-x
    goto @loop
end if

end
