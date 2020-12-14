return function(properties)

	if not properties.backgroundAlpha then
		properties.backgroundAlpha = 0
	end

	properties.image = "devgit:assets/images/logo.png"

	properties.imageColour = colour.black()
	properties.imageAlpha = 0.2

	local logoShadow = core.construct("guiImage", properties)
	local logo = logoShadow:clone({
		parent = logoShadow,
		position = guiCoord(0, 0, 0, -2),
		size = guiCoord(1, 2, 1, 2),
		imageColour = colour.white(),
		imageAlpha = 1.0
	})
end
