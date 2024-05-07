rem *****************************
rem Algoritmus bubble sort
rem 
rem Úprava pro EndBASIC
rem 
rem *****************************

dim a(21)

for i=0 to 20
  a(i)=int(100*rnd(1))
next

gosub @PRINT_ARRAY

for i=19 to 0 step -1
  print ".";
  for j=0 to i
    if a(j)<a(j+1) then
        x=a(j)
        a(j)=a(j+1)
        a(j+1)=x
    end if
  next
next
print ""
print "sorted:"

gosub @PRINT_ARRAY
end

@PRINT_ARRAY
rem Tisk obsahu pole
for i=0 to 20
  print i,a(i)
next
return 
