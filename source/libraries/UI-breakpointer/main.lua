-- crude implementation
local breakpointer = {}
local boundGuis = {}

-- Store a list of breakpoints
local breakpoints = {
	{"xs", 0},
	{"sm", 576},
	{"md", 768},
	{"lg", 992},
	{"xl", 1200},
	{"xxl", 1600}
}

-- Remap these breakpoints into a dictionary for the end-user
breakpointer.breakpoints = {}
for i, v in pairs(breakpoints) do
	breakpointer.breakpoints[v[1]] = v[2]
	breakpoints[i][3] = i
end

local function getBreakpointFromSize(size)
	for _, v in pairs(breakpoints) do
		if v[2] == size then
			return v
		end
	end
end

-- Logic for selecting a breakpoint based on screen size
local currentBreakpoint = breakpoints[1]

local selectBreakpoint = function()
	local screenSize = core.input.screenSize
	currentBreakpoint = breakpoints[#breakpoints]
	for i = 1, #breakpoints do
		local bp = breakpoints[i]
		if bp[2] < screenSize.x then
			currentBreakpoint = bp
		end
	end

	print("BP is now", currentBreakpoint[1])
end

selectBreakpoint()

-- Logic for updating bound UIs on screen resize

local updateUI = function(object)
	-- select appropriate breakpoint
	if boundGuis[object] and boundGuis[object][currentBreakpoint[1]] then
		for k, v in pairs(boundGuis[object][currentBreakpoint[1]]) do
			object[k] = v
		end
	end
end

-- Logic for binding a breakpoint to a object

function breakpointer:bind(object, breakpoint, properties)
	local bp = breakpointer.breakpoints[breakpoint]
	if not type(breakpoint) == "string" or not bp then
		return error("Breakpoint invalid", 2)
	end

	bp = getBreakpointFromSize(bp)

	if not boundGuis[object] then
		boundGuis[object] = {}
		for _, v in pairs(breakpoints) do
			boundGuis[object][v[1]] = {}
		end

		object:on("destroying", function()
			boundGuis[object] = nil
		end)
	end

	for k, v in pairs(properties) do
		if object[k] ~= nil and type(object[k]) ~= "function" then
			-- apply properties to all breakpoints higher
			for i = bp[3], #breakpoints, 1 do
				local breakpoint = breakpoints[i]
				boundGuis[object][breakpoint[1]][k] = v
			end
			boundGuis[object][bp[1]][k] = v
		end
	end

	updateUI(object)
end

local function onResized()
	selectBreakpoint()
	for gui, _ in pairs(boundGuis) do
		updateUI(gui)
	end
end

core.input:on("screenResized", onResized)

return breakpointer
