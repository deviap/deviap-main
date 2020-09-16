-- Copyright 2020 - Deviap (deviap.com)

local newBaseComponent = require("devgit:source/libraries/UI/components/baseComponent.lua")

return function(props)
    --[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
    ]]

    props.isContainer = props.isContainer or false

    local self = newBaseComponent(props)
    self.container.size = guiCoord(0, 512, 0, 38)
    self.container.backgroundAlpha = 0

    local tabs = {}
    local pages = {}

    local function selectTab(tab) 
        for t,v in pairs(pages) do
            v.visible = false
            t.props.isContainer = props.isContainer
            t.state.dispatch { type = "deselect" }
        end

        pages[tab].visible = true
        tab.state.dispatch { type = "select" }
    end

    self.addTab = function(tab, page)
        table.insert(tabs, tab)
        pages[tab] = page
        tab.container:on("mouseLeftUp", function()
            selectTab(tab)
        end)

        tab.props.isContainer = props.isContainer
        tab.state.dispatch { type = "deselect" }
        self.render()

        for i = 1, #tabs do
            tabs[i].borderRight.lineAlpha = 1
        end
        tab.borderRight.lineAlpha = 0

        selectTab(tabs[1])
    end

    self.render = function()
        --[[
			@description
				Renders the component
			@parameter
				nil
			@returns
				nil
        ]]

        if props.size then
            self.container.size = props.size
        end

        local s = 1/#tabs

        for i,v in pairs (tabs) do
            v.container.parent = self.container
            v.container.position = guiCoord(s*(i-1), 0, 0, 6)
            v.container.size = guiCoord(s, 0, 1, -6)
        end
    end

    self.render()

    return self
end
