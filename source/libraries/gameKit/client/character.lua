---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

core.input:on("keyDown", function(key)
    if key == "KEY_W" then
        core.networking:sendToServer("keyDown", "forward")
    elseif key == "KEY_S" then
        core.networking:sendToServer("keyDown", "backward")
    elseif key == "KEY_A" then
        core.networking:sendToServer("keyDown", "left")
    elseif key == "KEY_D" then
        core.networking:sendToServer("keyDown", "right")
    elseif key == "KEY_SPACE" then
        core.networking:sendToServer("keyDown", "jump")
    end
end)

core.input:on("keyUp", function(key)
    if key == "KEY_W" then
        core.networking:sendToServer("keyUp", "forward")
    elseif key == "KEY_S" then
        core.networking:sendToServer("keyUp", "backward")
    elseif key == "KEY_A" then
        core.networking:sendToServer("keyUp", "left")
    elseif key == "KEY_D" then
        core.networking:sendToServer("keyUp", "right")
    elseif key == "KEY_SPACE" then
        core.networking:sendToServer("keyUp", "jump")
    end
end)