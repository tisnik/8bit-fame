rem *****************************
rem
rem Práce s dvourozměrnymi poli
rem 
rem Úprava pro EndBASIC
rem 
rem *****************************



rem Deklarace pole
dim m(6,6)

rem Naplnění pole
for i=0 to 5
  for j=0 to 5
    m(i,j)=i*j
  next
next

rem Tisk pole
for i=0 to 5
  for j=0 to 5
    print m(i,j),
    next
  print 
next

end
