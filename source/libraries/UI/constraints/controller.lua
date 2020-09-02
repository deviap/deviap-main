local newTabulars = require("tevgit:source/libraries/UI/constraints/tabResolver.lua")

local controllers =
{
    horizontialLayoutAuto = function()
        local public = {}
        local newTabResolver = newTabulars()

        public.container = core.construct("guiFrame")
        
        local constraints = newTabulars()

        public.refresh = function()

        end
        public.destroy  = function()

        end
        
        public.objects = {}

        public.isAutoRefreshOnChanged = false -- or be the integer key of "changed" prop.

        return public
    end;
}

local new = function(controllerName, ...)
    return controllers[controllerName](...)
end

return new