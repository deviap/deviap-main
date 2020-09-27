-- Copyright 2020 - Deviap (deviap.com)

return {
	name 		= "Develop",
	iconId 		= "code",
	iconType	= "material",
	construct 	= function(parent)

		local heading = core.construct("guiTextBox", {
			parent = parent,
			text = "Develop",
			size = guiCoord(1, 0, 0, 38),
			textSize = 38,
			textFont = "deviap:fonts/openSansExtraBold.ttf",
		})

	end
}