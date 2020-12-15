---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local camera = core.scene.camera
local selection = require("client/scripts/controllers/selection.lua")
local outliner = require("client/scripts/controllers/outliner.lua")

return {
	name = "select",
	iconId = "gps_not_fixed",

	activate = function(self)
		-- A cylinder which follows the user's cursor:
		self.cursorHighlighter = core.construct("block", {
			renderQueue = 200, -- this render the block over the rest of the scene
			emissiveColour = colour.rgb(0, 255, 0),
			scale = vector3(0.25, 0.01, 0.25),
			mesh = "deviap:3d/torus.glb"
		})

		self.mouseLeftUp = core.input:on("mouseLeftUp", function()
			if core.input:isKeyDown(enums.keys.KEY_LSHIFT) then
				if self.hover then
					selection.select(self.hover)
				end
			else
				if self.hover then
					selection.set {self.hover}
				else
					selection.clear()
				end
			end
		end)

		self.mouseRightUp = core.input:on("mouseRightUp", function()
			if self.hover then
				selection.deselect(self.hover)
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
					-- hide the torus
					self.cursorHighlighter.visible = false

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
		
		self.cursorHighlighter:destroy()
		self.cursorHighlighter = nil

		self.hover = nil
	end
}
