return function(props)
	local parent = props.parent
	local box1Width = props.box1Width or 0.5
	local orientation = props.orientation or "horizontial"
	local lineWidth = props.lineWidth or 10
	local container = props.container or core.construct("guiFrame", { parent = parent })
	local box1 = props.box1 or core.construct("guiFrame")
	
	local container = core.construct("guiFrame", {
		parent = parent
	})
	core.construct("guiFrame", {
		parent = container,
		size = orientation == "horizontial" 
			and guiCoord(box1Width, -lineWidth/2, 1, 0) 
			or guiCoord(box1Width, -lineWidth/2, 1, 0),
		position = guiCoord(0, 0, 0, 0)

	}) -- box1
	core.construct("guiFrame", {
		parent = container,
		size = orientation == "horizontial" 
			and guiCoord(1 - box1Width, -lineWidth/2, 1, 0) 
			or guiCoord(1, 0, 1 - box1Width, -lineWidth/2),
		position = orientation == "horizontial" 
			and guiCoord(box1Width, lineWidth, 0, 0) 
			or guiCoord(0, 0, box1Width, lineWidth),
	}) -- box2
	core.construct("guiFrame", {
		parent = container,
		size = orientation == "horizontial" 
			and guiCoord(0, lineWidth, 1, 0) 
			or guiCoord(1, 0, 1 - box1Width, -lineWidth/2),
		position = orientation == "horizontial" 
			and guiCoord(box1Width, 0, 0, 0) 
			or guiCoord(0, 0, box1Width, 0),
	}) -- middle line
end