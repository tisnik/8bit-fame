1 rem ********************************
2 rem Bubble sort pro pole typu single
3 rem 
4 rem Uprava pro Microsoft BASIC
5 rem
6 rem Upraveno do podoby benchmarku
7 rem
8 rem ********************************
9 rem
10 rem casovac
11 t1 = timer
12 rem
20 rem vlastni benchmark
21 max%=200
22 dim a%(max%)
23 for i%=0 to max%
24 a%(i%)=int(100*rnd(1))
25 next i%
26 gosub 100:rem tisk obsahu pole
27 for i%=max%-1 to 0 step -1
28 print ".";
29 for j%=0 to i%
30 if a%(j%)<a%(j%+1) then x=a%(j%):a%(j%)=a%(j%+1):a%(j%+1)=x
31 next j%
32 next i%
33 print ""
34 print "sorted:"
35 gosub 100:rem tisk obsahu pole
40 rem precteni casovace
42 t2=timer
50 print "finished in ";t2-t1;" seconds"
99 end 
100 rem tisk obsahu pole
101 for i%=0 to max%
102 print i%,a%(i%)
103 next i%
104 return 

