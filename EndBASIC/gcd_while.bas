rem *****************************
rem
rem Výpočet největšího společného
rem dělitele.
rem 
rem Úprava pro EndBASIC
rem (využití smyčky WHILE-WEND)
rem 
rem *****************************



print "x=";
input x
print "y=";
input y

while x<>y
  if x>y then x=x-y
  if x<y then y=y-x
wend

print "gcd: ";x

end
