' Práce s grafikou na úrovni jednotlivých pixelů

GraphicsWindow.Show()
GraphicsWindow.BackgroundColor = GraphicsWindow.GetColorFromRGB(0,0,0)

for y = 0 to 255
    for x = 0 to 255
        color = GraphicsWindow.GetColorFromRGB(x, 0, y)
        GraphicsWindow.SetPixel(x, y, color)
    endfor
endfor