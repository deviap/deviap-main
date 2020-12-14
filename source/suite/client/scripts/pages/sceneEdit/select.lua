---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
local camera = core.scene.camera

return {
	name = "select",
	iconId = "gps_not_fixed",

	activate = function(self)
		-- A cylinder which follows the user's cursor:
		self.selectionHighlighter = core.construct("block", {
			renderQueue = 200, -- this render the block over the rest of the scene
			emissiveColour = colour.rgb(0, 255, 0),
			scale = vector3(0.5, 0.01, 0.5),
			alpha = 0.2,
			mesh = "deviap:3d/torus.glb"
		})

		spawn(function()

			while sleep() and self.active do

				-- Calculate the camera's position and the cursor's direction
				local camPos = camera.position
				local mousePos = camera:screenToWorld(core.input.mousePosition) * 500

				-- Perform the raycast, exclude our selection highlighter
				local hits = core.scene:raycast(camPos, camPos + mousePos, {
					self.selectionHighlighter
				})

				if #hits > 0 then
					-- show and position the torus
					self.selectionHighlighter.visible = true
					self.selectionHighlighter.position = hits[1].position
					self.selectionHighlighter.rotation = quaternion.lookRotation(hits[1].normal * 10)
					self.selectionHighlighter.rotation = self.selectionHighlighter.rotation * quaternion.euler(math.rad(90), 0, 0)

					-- if we've set up a wireframe in a previous frame, update its position
					if self.hoverWireframe then
						self.hoverWireframe.position = hits[1].hit.position
					end

					-- if the hovered object has changed, we'll need to recreate the wireframe
					if self.hover ~= hits[1].hit then
						self.hover = hits[1].hit

						if self.hoverWireframe then
							self.hoverWireframe:destroy()
						end

						self.hoverWireframe = self.hover:clone({
							wireframe = true,
							emissiveColour = colour.rgb(0, 255, 0),
							renderQueue = 200
						})
					end
				else
					-- hide the torus
					self.selectionHighlighter.visible = false

					-- remove any wireframes as the user is not hovering over anything.
					if self.hoverWireframe then
						self.hoverWireframe:destroy()
						self.hoverWireframe = nil
					end

					self.hover = nil
				end
			end
		end)
	end,

	deactivate = function(self)
		self.selectionHighlighter:destroy()
		self.selectionHighlighter = nil

		if self.hoverWireframe then
			self.hoverWireframe:destroy()
			self.hoverWireframe = nil
		end

		self.hover = nil
	end
}
