---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local camera = core.scene.camera
local selection = require("client/scripts/controllers/selection.lua")
local translation = require("client/scripts/controllers/translation.lua")
local outliner = require("client/scripts/controllers/outliner.lua")

local step = 1 -- make gui input
local draw

return {
    name = "translate",
    description = "Desc",
    iconId = "open_with",
    
    activate = function(self)
        self.mouseLeftUp = core.input:on("mouseLeftUp", function()
			if core.input:isKeyDown(enums.keys.KEY_LSHIFT) then
                if self.hover then
					selection.select(self.hover)
				end
            else
                -- Handle selections that are not handles.
                if self.hover and not string.find(self.hover.name, "Handle") then
                    if selection.get() then
                        translation.detach(selection.get())
                    end
                    selection.set {self.hover}
                    translation.attach(self.hover)
                -- Handle selections that are handles.
                elseif self.hover and string.find(self.hover.name, "Handle") then
                    local face = string.sub(self.hover.name, 1, (string.find(self.hover.name, "H"))-1)
                    local shift = translation.getFaceMapping(face)[1]
                    -- Apply action / trigger on each handle based on face.

                    -- Remove axis if draw is valid.
                    if draw then
                        draw:destroy()
                    end

                    draw = core.construct("block", {
                        position = self.hover.parent.position,
                        scale = vector3(0.02, 0.02, 0.02)+(shift*99),
                        colour = colour.hex("546E7A"),
                        emissiveColour = colour.hex("546E7A"),
                        renderQueue = 200
                    })

                    
				end
			end
		end)

		self.mouseRightUp = core.input:on("mouseRightUp", function()
            if self.hover then
                if draw then
                    draw:destroy()
                    draw = nil
                end
                translation.detach(self.hover)
                selection.deselect(self.hover)
			end
		end)

		spawn(function()
			while sleep() and self.active do

				-- Calculate the camera's position and the cursor's direction
				local camPos = camera.position
				local mousePos = camera:screenToWorld(core.input.mousePosition) * 500

				-- Perform the raycast, exclude our selection highlighter
				local hits = core.scene:raycast(camPos, camPos + mousePos, {})

				if #hits > 0 then

					-- if the hovered object has changed, we'll need to delete old wireframe
					if self.hover ~= hits[1].hit then
						if self.hover and not selection.isSelected(self.hover) then
							outliner.remove(self.hover)
						end
						
						self.hover = hits[1].hit
					end

					if not selection.isSelected(self.hover) then
						-- add wireframe
						outliner.add(self.hover, colour(0, 1, 0))
					end
				else

					-- remove any wireframes as the user is not hovering over anything.
					if not selection.isSelected(self.hover) then
						outliner.remove(self.hover)
					else
						-- don't remove wireframe, this object is selected
						outliner.update(self.hover)
					end

					self.hover = nil
				end
			end
		end)
	end,

	deactivate = function(self)
		core.disconnect(self.mouseLeftUp)
		core.disconnect(self.mouseRightUp)

		self.hover = nil
	end
}