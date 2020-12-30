---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/sample-apps/blob/master/LICENSE --
---------------------------------------------------------------
--
local controller = {}

function controller.open(fileType, title, allowNew)
    local result = ""
    if not fileType then fileType = "" end
    title = title or "Open"

	local backdrop = core.construct("guiFrame", {
		parent = core.interface,
		size = guiCoord(1, 460, 1, 400),
		position = guiCoord(0, -230, 0, -200),
		backgroundColour = colour(0, 0, 0),
		zIndex = 1000,
		backgroundAlpha = 0
    })

    core.tween:begin(backdrop, 1, {
        backgroundAlpha = 0.6
    }, "inOutQuad")
    
    backdrop:on("mouseLeftUp", function()
        result = "new"
    end)

	local container = core.construct("guiFrame", {
		parent = backdrop,
		size = guiCoord(0, 230, 0, 220),
		position = guiCoord(0.5, -115, 0.5, -80),
		backgroundColour = colour(1, 1, 1),
		strokeRadius = 4,
		strokeAlpha = 0.2
	})

    core.tween:begin(container, 1, {
        position = guiCoord(0.5, -115, 0.5, -110)
    }, "inOutQuad")

	core.construct("guiTextBox", {
		parent = container,
		size = guiCoord(1, -20, 0, 24),
        position = guiCoord(0, 10, 0, 9),
        text = title,
        textFont = "deviap:fonts/openSansBold.ttf",
        textSize = 24
    })

	core.construct("guiIcon", {
		parent = container,
		size = guiCoord(0, 20, 0, 20),
        position = guiCoord(1, -30, 0, 10),
        iconId = "note_add",
        iconMax = 18,
        iconColour = colour(0, 0, 0)
    }):on("mouseLeftUp", function()
        result = "new"
    end)

    local innerContainer = core.construct("guiFrame", {
		parent = container,
		size = guiCoord(1, -20, 1, -45),
        position = guiCoord(0, 10, 0, 40),
        backgroundAlpha = 0
    })

    allowNew = true
    if allowNew then
        innerContainer.size = guiCoord(1, -20, 1, -70)

        local input = core.construct("guiTextBox", {
            parent = container,
            size = guiCoord(1, -70, 0, 18),
            position = guiCoord(0, 10, 1, -28),
            text = "newfilename",
            textSize = 16,
            strokeAlpha = 0.2,
            strokeRadius = 4,
            textEditable = true
        })

        local btn = core.construct("guiTextBox", {
            parent = container,
            size = guiCoord(0, 40, 0, 18),
            position = guiCoord(1, -50, 1, -28),
            text = "",
            textSize = 16,
            strokeAlpha = 0.2,
            strokeRadius = 4,
            text = "NEW",
            textAlign = "middle",
            backgroundColour = colour.hex("#e57373"),
            textColour = colour.white()
        })

        btn:on("mouseLeftUp", function()
            result = "client/assets/" .. input.text .. ".json"
        end)
    end
    
    local y = 0
    for _,v in pairs(core.io:list()) do
        if v:sub((v:len() - fileType:len()) + 1) == fileType then
            local btn = core.construct("guiTextBox", {
                parent = innerContainer,
                size = guiCoord(1, 0, 0, 18),
                position = guiCoord(0, 0, 0, y),
                text = " " .. v,
                textSize = 16,
                strokeAlpha = 0.2,
                strokeRadius = 4
            })

            btn:on("mouseEnter", function()
                btn.textFont = "deviap:fonts/openSansBold.ttf"
            end)

            btn:on("mouseExit", function()
                btn.textFont = "deviap:fonts/openSansRegular.ttf"
            end)

            btn:on("mouseLeftUp", function()
                result = v
            end)

            y = y + 20
        end
    end

    while result == "" do
        sleep(0.1)
    end

    backdrop:destroy()
    return result
end

return controller
