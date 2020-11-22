---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------

core.scene.simulate = true

local characters = {}

local function onConnection(client)
    local character = core.construct("block", {
        scale = vector3(1, 1, 1),
        position = vector3(0, 3, 0),
        colour = colour.random(),
        static = false
    })

    characters[client.name] = character
end

core.networking:on("_clientConnected", onConnection)
for _,client in pairs(core.networking.clients) do onConnection(client) end

core.networking:on("_clientDisconnected", function(client)
    if characters[client.name] then
        characters[client.name]:destroy()
        characters[client.name] = nil
    end
end)

core.networking:on("keyDown", function(client, action)
    if not characters[client.name] then
        return
    end

    if action == "forward" then
        print("forward")
        characters[client.name]:applyForce(vector3(0, 20, 35))
    end
end)

spawn(function()
    while sleep() do
        print("spawn")
        local test = core.construct("block", {
            scale = vector3(1, 1, 1),
            position = vector3(2, 3, 0),
            colour = colour.random(),
            static = false
        })
        sleep(1)
        test:destroy()
        sleep(.5)
    end
end)