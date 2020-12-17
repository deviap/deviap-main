
require("./hierarchy.lua"){
	parent = core.construct("guiFrame", {
		parent = core.interface,
		zIndex = 10,
		size = guiCoord(1, 0, 1, 0)
	});
	size = guiCoord(0, 400, 0, 800);
	position = guiCoord(0, 50, 0, 0);
	backgroundColour = colour(0.1, 0.1, 0.1),
	textColour = colour(0.9, 0.9, 0.9),
	hierarchy = {
		{
			text = "Teams",
			icon = "groups",
			children = {
				{
					text = "Product Engineering",
					icon = "engineering",
					children = {
						{
							text = "Jay",
							icon = "assignment_ind"
						},
						{
							text = "Sanjay",
							icon = "assignment_ind"
						},
						{
							text = "Ly",
							icon = "account_circle"
						},
						{
							text = "utrain",
							icon = "account_circle"
						}
					}
				},
				{
					text = "Information Experience",
					icon = "text_snippet",
					children = {
						{
							text = "Ryan",
							icon = "assignment_ind",
						},
						{
							text = "Sanjay",
							icon = "assignment_ind"
						},
						{
							text = "Neztore",
							icon = "account_circle"
						},
						{
							text = "popeeyy",
							icon = "account_circle"
						}
					}
				},
				{
					text = "Community Relations",
					icon = "analytics",
					children = {
						{
							text = "Ryan",
							icon = "assignment_ind"
						},
						{
							text = "Sanjay",
							icon = "assignment_ind",
						},
						{
							text = "Zaydan",
							icon = "account_circle",
						},
						{
							text = "zachary23111",
							icon = "account_circle",
						},
						{
							text = "Roman",
							icon = "account_circle",
						},
						{
							text = "August",
							icon = "account_circle"
						},
						{
							text = "Trapido02",
							icon = "account_circle"
						}
					}
				}
			}
		},
		
	},
	buttonHeight = 25
}