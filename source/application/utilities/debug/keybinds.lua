-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): Sanjay-B(Sanjay)

-- All keybinds used for debugging internally. Tevgit has to be overridden to enable all but the Tevgit Prompt

local graphicsDebug = false
if core.dev.localTevGit then core.interface:child("outputWindow").visible = true end -- Set to true if tevgit is overridden, otherwise hide it.

core.input:on("keyDown", function(key)

    -- Output Window Enable / Disable
    if key == "KEY_F1" and core.dev.localTevGit then core.interface:child("outputWindow").visible = not core.interface:child("outputWindow").visible

    -- Hard Reset Application
    elseif key == "KEY_F2" and core.dev.localTevGit then core.apps:reset()

    -- Prompts Tevgit
    elseif key == "KEY_F3" then core.dev:promptTevGit()

    -- Hard Reload Shaders
    elseif key == "KEY_F4" and core.dev.localTevGit then core.dev:reloadAllShaders()

    -- Graphics Debug Enable / Disable
    elseif key == "KEY_F5" and core.dev.localTevGit then graphicsDebug = not graphicsDebug core.graphics:setDebug(graphicsDebug)
    end
end)