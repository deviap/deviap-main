-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Mooshua, Kisperal

-- Creates base component class


local Rawstate = require("tevgit:source/libraries/UI/component-builtins/raw.lua")
local State = require("tevgit:source/libraries/UI/component-builtins/state.lua")

return function (Creator)

    local CLASS = {}
    


    local CLASS = {
        construct = function(Props)

            --  -------------------
            --  Create the instance
            --  -------------------

            local self = {

                public = {},
                public = {}

            }

            local builtin = {
                state = function(...)
                    return RawState(false,...)
                end,
                history = function(...)
                    return State(false,...)
                end,
            }

            --  --------------------------------
            --  Introduce states to the instance
            --  --------------------------------
            
            local function Introduce(To,List)

                for Index,Data in pairs(List) do
                    if (tonumber(Index)) then

                        self[To][Data] = builtin.state(nil)
                    else
                        self[To][Index] = Data(nil)
                    end
                end
                    
            end

            function self.props(List)
                Introduce("public",List)
            end

            function self.internal(List)
                Introduce("private",List)
            end

            --  -------------------
            --  Create the instance
            --  ------------------- 
            Creator(self,builtin)

            --  ------------
            --  Sanitization
            --  ------------

            self.private = nil
            self.internal = nil
            self.props = nil
            self.state = nil
            self.push = function(Props)
                for Prop,Value in pairs(Props) do
                    self.public[Prop].push(Value)
                end
            end

            --  -----------------
            --  Set default props
            --  -----------------

            for Key,Value in pairs(Props or {}) do

                if (self.public[Key]) then
                     self.public[Key].push(Value)
                end
            end            

            --  ---------
            --  All done!
            --  ---------

            return self
        end

    }


    return CLASS

end