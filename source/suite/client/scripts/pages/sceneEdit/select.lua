---------------------------------------------------------------
-- Copyright 2021 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local camera = core.scene.camera
local selection = require("client/scripts/controllers/selection.lua")

return {
	name = "select",
	iconId = "gps_not_fixed",

	activate = function(self)
		-- A cylinder which follows the user's cursor:
		self.cursorHighlighter = core.construct("block", {
			renderQueue = 200, -- this render the block over the rest of the scene
			emissiveColour = colour.rgb(0, 255, 0),
			scale = vector3(0.25, 0.01, 0.25),
			mesh = "deviap:3d/torus.glb",
			simulated = false
		})

		self.mouseLeftDown = core.input:on("mouseLeftDown", function(pos, systemHandled)
			if systemHandled then return end

			if self.hover and self.hover.name:sub(0, 2) == "__" then
				return false
			end

			if core.input:isKeyDown(enums.keys.KEY_LSHIFT) then
				if self.hover then
					if selection.isSelected(self.hover) then
						selection.deselect(self.hover)
					else
						selection.select(self.hover)
					end
				end
			else
				if self.hover then
					if not selection.isSelected(self.hover) then
						selection.set {self.hover}
					end
				else
					selection.clear()
				end
			end
		end)

		spawn(function()
			while sleep() and self.active do

				-- Calculate the camera's position and the cursor's direction
				local camPos = camera.position
				local mousePos = camera:screenToWorld(core.input.mousePosition) * 500

				-- Perform the raycast, exclude our selection highlighter
				local hits = core.scene:raycast(camPos, camPos + mousePos, {
					self.cursorHighlighter
				})

				if #hits > 0 then
					-- show and position the torus
					self.cursorHighlighter.visible = true
					self.cursorHighlighter.position = hits[1].position
					self.cursorHighlighter.rotation = quaternion.lookRotation(hits[1].normal * 10) * quaternion.euler(math.rad(90), 0, 0)

					self.hover = hits[1].hit
				else
					-- hide the torus
					self.cursorHighlighter.visible = false
					self.hover = nil
				end
			end
		end)
	end,

	deactivate = function(self)
		core.disconnect(self.mouseLeftDown)
		
		self.cursorHighlighter:destroy()
		self.cursorHighlighter = nil

		self.hover = nil
	end
}
