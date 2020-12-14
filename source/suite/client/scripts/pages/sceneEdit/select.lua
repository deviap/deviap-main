---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
return {
	name = "select",
	iconId = "gps_not_fixed",

	activate = function(self)
		self.selectionHighligher = core.construct("block", {
            renderQueue = 200, -- this render the block over the rest of the scene
            emissiveColour = colour.rgb(0, 255, 0),
            scale = vector3(0.5, 0.1, 0.5),
            mesh = "deviap:3d/cylinder.glb"
        })

		spawn(function()
            while sleep() and self.active do
                local camPos = core.scene.camera.position
                local mousePos = core.scene.camera:screenToWorld(core.input.mousePosition) * 500
                local hits = core.scene:raycast(camPos, camPos + mousePos, self.selectionHighligher)
				if hits[1] then
					self.selectionHighligher.position = hits[1].position
				end
			end
		end)
	end,

	deactivate = function(self)
		self.selectionHighligher:destroy()
		self.selectionHighligher = nil
	end
}
