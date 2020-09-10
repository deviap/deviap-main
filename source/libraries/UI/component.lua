-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay), utrain

-- Creates base component class

return function(props)
    local self = {}
    self.props = props
    self.states = nil -- states sub-component
    self.state = nil
    self.container = nil
    self.visiblity = nil
    self.render = nil
    self.push = function(props)
        if self.props == nil or self.container == nil then return end
        for prop, value in pairs(props) do
            self.props[prop] = value
            self.container[prop] = value
        end
    end
    return self
end

