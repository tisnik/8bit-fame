rem *****************************
rem
rem Smyčka typu FOR-NEXT
rem s průběžnou změnou kroku
rem změny počitadla smyčky.
rem 
rem Úprava pro EndBASIC
rem
rem *****************************



s=1
for i=0 to 20 step s
  print i,s
  s=s+1
next i
