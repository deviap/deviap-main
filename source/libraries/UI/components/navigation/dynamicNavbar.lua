---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
-- Creates a navbar instance
local newBaseComponent = require("devgit:source/libraries/UI/components/customBaseComponent.lua")
local navItem = require("devgit:source/libraries/UI/components/navigation/customNavItem.lua")
local tagItem = require("devgit:source/libraries/UI/components/misc/tagItem.lua")

return function(props)
	--[[
		@description
			Creates a base component
		@parameter
			table, props
		@returns
			table, component
    ]]
    
    local padding = 15
    local size = 62-padding*2

    local self = newBaseComponent(props)
    self.container.size = props.size
    self.container.position = props.position
    self.container.zIndex = props.zIndex
    self.container.backgroundColour = colour.hex("212121")
    self.container.backgroundColourB = colour.hex("212121")
    self.container.dropShadowAlpha = 1
    self.container.dropShadowBlur = 5
    self.container.dropShadowColour = colour.hex("F5F5F5")

    local bottomOffset = props.bottomOffset or 0

    self.topItems = {}
    self.bottomItems = {}
    self.currentPage = nil
    self.extensionNav = props.extensionNav

    -- Hard Reset for Navbar; currentPage sets to nil
    self.hardReset = function()
        if self.currentPage ~= nil then
            self.currentPage.visible = false
            self.currentPage = nil
        end
    end

    self.addNavItem = function(_props)

        local page = core.construct("guiFrame", {
            parent = core.engine.coreInterface,
            size = guiCoord(0, 283, 1, 0),
            position = guiCoord(0, 60, 0, 0),
            backgroundColour = colour.hex("212121"),
            backgroundAlpha = 1,
            strokeWidth = 2,
            strokeColour = colour.hex("F5F5F5"),
            dropShadowAlpha = 1,
            dropShadowBlur = 5,
            dropShadowColour = colour.hex("F5F5F5"),
            visible = false,
            zIndex = 3
        })

        if _props.relativeLocation == "top" then
            if _props.redirect ~= nil then
                _props.redirect.construct(page)
            end

            local num = #self.topItems+1
            local _navItem = navItem {
                navOrientation = props.orientation,
                position = guiCoord(0, 0, 0, 0),
                iconColour = props.iconColour,
                size = _props.size,
                iconMax = _props.iconMax,
                iconId = _props.iconId,
                tooltip = _props.tooltip,
                redirect = function()
                    if not self.extensionNav then
                        if self.currentPage ~= nil then
                            self.currentPage.visible = false
                        end
                        self.currentPage = page
                        self.currentPage.visible = true
                    elseif self.extensionNav then
                        if self.extensionNav.currentPage ~= nil then
                            self.extensionNav.currentPage.visible = false
                        end
                        self.extensionNav.currentPage = page
                        self.extensionNav.currentPage.visible = true
                    end
                end
            }
            table.insert(self.topItems, #self.topItems+1, _navItem)
        elseif _props.relativeLocation == "bottom" then
            if _props.redirect ~= nil then
                _props.redirect.construct(page)
            end
            
            local num = #self.bottomItems+1
            local _navItem = navItem {
                navOrientation = props.orientation,
                position = guiCoord(0, 0, 0, 0),
                iconColour = props.iconColour,
                size = _props.size,
                iconMax = _props.iconMax,
                iconId = _props.iconId,
                tooltip = _props.tooltip,
                redirect = function()
                    if self.currentPage ~= nil then
                        self.currentPage.visible = false
                    end
                    self.currentPage = page
                    self.currentPage.visible = true
                end
            }

            table.insert(self.bottomItems, #self.bottomItems+1, _navItem)
        end
        
        self.render()
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

        if self.container.absoluteSize.x < self.container.absoluteSize.y then
            for index, navItem in pairs(self.topItems) do
                navItem.container.parent = self.container
                navItem.container.position = guiCoord(0, self.container.absoluteSize.x/2-navItem.container.absoluteSize.x/2, 0, (index-1)*size+index*padding)
            end

            for index, navItem in pairs(self.bottomItems) do
                navItem.container.parent = self.container
                navItem.container.position = guiCoord(0, self.container.absoluteSize.x/2-navItem.container.absoluteSize.x/2, 1, -1*((index-1)*size+index*padding)-navItem.container.absoluteSize.y)
            end
        else
            for index, navItem in pairs(self.topItems) do
                navItem.container.parent = self.container
                navItem.container.position = guiCoord(0, (index-1)*size+index*padding, 0, self.container.absoluteSize.y/2-navItem.container.absoluteSize.y/2)
            end

            for index, navItem in pairs(self.bottomItems) do
                navItem.container.parent = self.container
                navItem.container.position = guiCoord(1, -1*((index-1)*size+index*padding)-navItem.container.absoluteSize.x-bottomOffset, 0,  self.container.absoluteSize.y/2-navItem.container.absoluteSize.y/2)
            end
        end
    end
    
	self.render()

	return self
end