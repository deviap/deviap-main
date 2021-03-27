-- Copyright 2020 - Deviap (deviap.com)
-- Entry point for UI library.

return {
    newComponent = require("devgit:source/libraries/UI/components.lua"),
    newTabResolver = require("devgit:source/libraries/UI/constraints.lua").newTabResolver,
    newController = require("devgit:source/libraries/UI/constraints.lua").newController,
    newEnum = require("devgit:source/libraries/UI/enum.lua"),
}
