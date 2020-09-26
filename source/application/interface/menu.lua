local modal = require("devgit:source/libraries/UI/components/modal.lua")

local menu = modal {parent = core.interface}

return {show = function() menu.show() end}
