-- Copyright 2020 - Deviap (deviap.com)

local button = require("devgit:source/libraries/UI/components/buttons/dangerButton.lua")
local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")
local textInput = require("devgit:source/libraries/UI/components/textInput.lua")
local numberInput = require("devgit:source/libraries/UI/components/numberInput.lua")
local progressStep = require("devgit:source/libraries/UI/components/progress/progressStep.lua")
local progressIndicator = require("devgit:source/libraries/UI/components/progress/progressIndicator.lua")

return function(parent)
	local _button = button {
		parent = parent,
		position = guiCoord(0, 310, 0, 40),
        text = "Button item"
    }
    
	textInput {
		parent = parent,
        position = guiCoord(0,0, 0, 40),
        size = guiCoord(0, 300, 0, 30),
        label = "Label optional",
        helper = "Helper optional",
        placeholder = "Optional Placeholder"
    }
    
	local email = textInput {
		parent = parent,
        position = guiCoord(0,510, 0, 100),
        size = guiCoord(0, 300, 0, 30),
        placeholder = "Username",
        helper = "Usually your email address"
    }

    email.input:on("keyUp", function()
        email.state.dispatch { 
            type = "invalidate",
            error = "Bad email address..." 
        }
    end)

	local num = numberInput {
		parent = parent,
        position = guiCoord(0,510, 0, 160),
        size = guiCoord(0, 300, 0, 30),
    }

	local _checkbox = checkbox {
		parent = parent,
		position = guiCoord(0,310, 0, 160),
		text = "Checkbox item"
	}
    
	local _progressStep1 = progressStep {
        text = "Progress Step 1",
        label = "optional label"
    }
    
	local _progressStep2 = progressStep {
		text = "Progress Step 2"
    }

	local _progressStep3 = progressStep {
		text = "Progress Step 3"
    }

    local _progressIndicator = progressIndicator {
		parent = parent,
        position = guiCoord(0, 20, 0, 230),
        steps = {
            _progressStep1,
            _progressStep2,
            _progressStep3
        },
        progress = 2
    }
    
    _progressStep1.state.dispatch { type = "setMode", mode = "complete" }
    _progressStep2.state.dispatch { type = "setMode", mode = "current" }
    _progressStep3.state.dispatch { type = "setMode", mode = "invalid"}
end