  scorecolor = $98

  rem Pocatecni hodnota score
  score = 0

mainloop
    if joy0fire then score = score + 1

    drawscreen
    goto mainloop
