' Události

GraphicsWindow.KeyDown = OnKeyDown

Sub OnKeyDown
    key = GraphicsWindow.LastKey
    TextWindow.WriteLine(key)
EndSub