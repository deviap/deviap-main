return function(props)
	props.menu = props.menu or {}
	--[[
		menu =
		{
			{
				icon = ""
				iconColour = secondaryColour
				text = ""
				textColour = primaryColour
				menu =
				{
					{
						icon = ""
						title = ""
						menu = nil
					}
				}
			}
		}
	]]

	props.spacing = props.spacing or 3
	props.primaryColour = props.primaryColour or colour(0, 0, 0.05)
	props.secondaryColour = props.secondaryColour or colour(1, 1, 1)

	local self = {}
	self.container = core.construct("guiFrame", { parent = props.parent })
	
	self.render = function()
		
	end

	self.props = props

	return self
end