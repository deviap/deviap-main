return function(parent)
    core.construct("guiTextBox", {
        parent = parent,
        size = guiCoord(1, 0, 0, 60),
        textSize = 50,
        text = "test"
    })
end