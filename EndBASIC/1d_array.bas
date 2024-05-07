rem *****************************
rem 
rem Práce s jednorozměrnými poli
rem 
rem Úprava pro EndBASIC
rem 
rem *****************************



rem Definice pole
dim a(11)

rem Naplnění pole
for i=0 to 10
  a(i)=10*i
next

rem Tisk pole
for i=0 to 10
  print a(i)
next

end 
