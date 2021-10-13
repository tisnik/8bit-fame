' Události

GraphicsWindow.MouseDown = MouseClick

Sub MouseClick
    x = GraphicsWindow.MouseX
    y = GraphicsWindow.MouseY
    TextWindow.WriteLine("x: " + x + "   y: " +y)
EndSub