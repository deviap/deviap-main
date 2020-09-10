-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

return function(props)
	--[[
		@description
			Defines specs for components.
		@parameter
			table, props
		@returns
			table, component
	]]

    local self = {}
    self.props = props
    self.push = function(props)
        if self.props == nil or self.container == nil then return end
        for prop, value in pairs(props) do
            self.props[prop] = value
            self.container[prop] = value
        end
	end

	self.states = nil
    self.container = nil
	self.render = nil

    return self
end

