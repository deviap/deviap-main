return function(properties, textColour)

    if not properties.backgroundAlpha then
        properties.backgroundAlpha = 1.0
    end

    if not properties.backgroundColour then
        properties.backgroundColour = colour.rgb(255, 255, 255)
    end

    properties.clip = false

    local mainBackdrop = core.construct("guiFrame", properties)

    local offset = mainBackdrop.absoluteSize.y < 100 and 5 or 10

    local dropShadow = core.construct("guiFrame", {
        parent = mainBackdrop,
        size = guiCoord(1.0, 0, 1.0, 0),
        position = guiCoord(0, -offset, 0, offset),
        backgroundColour = mainBackdrop.backgroundColour,
        backgroundAlpha = mainBackdrop.backgroundAlpha * 0.7
    })

    local logoText = core.construct("guiTextBox", {
        parent = mainBackdrop,
        size = guiCoord(1, 0, 0.9, 0), 
        backgroundAlpha = 0,
        text = "deviap",
        textColour = textColour and textColour or colour.black(),
        textAlign = "middle",
        textSize = mainBackdrop.absoluteSize.y * 0.9,
        textFont = "devgit:assets/fonts/monofonto.ttf"
    })

    return mainBackdrop, dropShadow, logoText
end