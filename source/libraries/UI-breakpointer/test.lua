local breakpointer = require("tevgit:source/libraries/UI-breakpointer/main.lua")

local btn = core.construct("guiTextBox", {
    parent = core.interface,
    size = guiCoord(0, 32, 0, 32),
    position = guiCoord(0.5, -16, 0.5, -16)
})

breakpointer:bind(btn, "xs", {
    backgroundColour = colour(1, 0, 0)
})

breakpointer:bind(btn, "sm", {
    backgroundColour = colour(0, 1, 0)
})

breakpointer:bind(btn, "md", {
    backgroundColour = colour(0, 0, 1)
})