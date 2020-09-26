-- Copyright 2020 - Deviap (deviap.com)
return {
    name = "Develop",
    iconId = "code",
    iconType = "material",
    construct = function(parent)

        local heading = core.construct("guiTextBox", {
            parent = parent,
            text = "Develop [placeholder page]",
            size = guiCoord(1, 0, 0, 38),
            textSize = 38,
            textFont = "deviap:fonts/openSansExtraBold.ttf"
        })

        core.construct("guiTextBox", {
            parent = parent,
            text = "Open Unpacked App",
            size = guiCoord(1, 0, 0, 20),
            position = guiCoord(0, 0, 0, 50),
            textColour = colour(1, 0, 0),
            backgroundColour = colour(0.9, 0.9, 0.9),
            textFont = "deviap:fonts/openSansExtraBold.ttf"
        }):on("mouseLeftUp", function() core.apps:promptAppDirectory() end)

    end
}
