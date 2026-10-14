graphics 7+16

' bila
setcolor 0, 0, 14

' tmave cervena
setcolor 1, 3, 8

' tmave modra
setcolor 2, 7, 4

max_x = 159
mid_x = 80
max_y = 79

' horní část vlajky
color 1
fcolor 1

' pravý okraj
plot max_x, 0
drawto max_x, max_y/2

' bílý segment
plot 0,0
fillto mid_x, max_y/2

' spodní část vlajky
color 2
fcolor 2

' pravý okraj
plot max_x, max_y/2+1
drawto max_x, max_y

' červený segment
plot 0, max_y
fillto mid_x, max_y/2

' modrý klín
color 3
fcolor 3
plot 0,1
fillto 0, max_y-1

do
loop
