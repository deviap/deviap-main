-- Copyright 2020 - Deviap (deviap.com)
local button = require("devgit:source/libraries/UI/components/buttons/dangerButton.lua")
local checkbox = require("devgit:source/libraries/UI/components/checkbox.lua")
local textInput = require("devgit:source/libraries/UI/components/textInput.lua")
local numberInput = require("devgit:source/libraries/UI/components/numberInput.lua")
local progressStep = require("devgit:source/libraries/UI/components/progress/progressStep.lua")
local progressIndicator = require("devgit:source/libraries/UI/components/progress/progressIndicator.lua")
local tab = require("devgit:source/libraries/UI/components/tabs/tab.lua")
local tabs = require("devgit:source/libraries/UI/components/tabs/tabs.lua")
local loading = require("devgit:source/libraries/UI/components/loading.lua")
local toggle = require("devgit:source/libraries/UI/components/toggle.lua")

return {
	name = "Component Library",
	iconId = "visibility",
	iconType = "material",
	construct = function(parent)
		-- Tabs --

		local tabs = tabs {parent = parent, position = guiCoord(0, 10, 0, 400), isContainer = true}

		local tab1 = tab {label = "tab 1"}

		local txt = core.construct("guiTextBox", {parent = parent, position = guiCoord(0, 10, 0, 450), text = "text"})

		tabs.addTab(tab1, txt)

		local tab2 = tab {label = "tab 2"}

		local txt2 = core.construct("guiTextBox", {parent = parent, position = guiCoord(0, 10, 0, 450), text = "text2"})

		tabs.addTab(tab2, txt2)

		local tab3 = tab {label = "tab 3"}

		local txt3 = core.construct("guiTextBox", {parent = parent, position = guiCoord(0, 10, 0, 450), text = "text3"})

		tabs.addTab(tab3, txt3)

		-- other crap --

		local _button = button {parent = parent, position = guiCoord(0, 310, 0, 60), text = "Button item"}

		textInput {
			parent = parent,
			position = guiCoord(0, 510, 0, 40),
			size = guiCoord(0, 300, 0, 30),
			label = "Label optional",
			helper = "Helper optional",
			placeholder = "Optional Placeholder"
		}

		local email = textInput {
			parent = parent,
			position = guiCoord(0, 510, 0, 100),
			size = guiCoord(0, 300, 0, 30),
			placeholder = "Username",
			helper = "Usually your email address"
		}

		email.input:on("keyUp", function()
			email.state.dispatch {type = "invalidate", error = "Bad email address..."}
		end)

		local num = numberInput {parent = parent, position = guiCoord(0, 510, 0, 160), size = guiCoord(0, 300, 0, 30)}

		local _checkbox = checkbox {parent = parent, position = guiCoord(0, 310, 0, 160), text = "Checkbox item"}

		local _progressStep1 = progressStep {text = "Progress Step 1", label = "optional label"}

		local _progressStep2 = progressStep {text = "Progress Step 2"}

		local _progressStep3 = progressStep {text = "Progress Step 3"}

		local _progressIndicator = progressIndicator {
			parent = parent,
			position = guiCoord(0, 20, 0, 230),
			steps = {_progressStep1, _progressStep2, _progressStep3},
			progress = 2
		}

		_progressStep1.state.dispatch {type = "setMode", mode = "complete"}
		_progressStep2.state.dispatch {type = "setMode", mode = "current"}
		_progressStep3.state.dispatch {type = "setMode", mode = "invalid"}

		local load = loading {parent = parent, position = guiCoord(0, 310, 0, 250)}
		load.spin()

		toggle {parent = parent, position = guiCoord(0, 310, 0, 300), label = "Spaghetti?", on = true}
	end
}
