-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain, Ya

-- Constraints using tabs. Some components of this are not implemented. This is not is also not the final interface.

local new = function()
	local public = {}
	public.tabs = { x = {}; y = {} }
	public.anchors = { x = {}; y = {} } -- ez reference

	public.registerRelativeTab = function(axis, tag, relativeTo, min, max, pref, weight)
		--[[
			@description
				Registers a new relative tab.

			@parameters
				string, axis
					Axis of which the new axis will be placed.
				string, tag
					The tag of the tab. Cannot conflict with already existing tags. Used to reference the tab.
				integer, min
					Minimum distance away from a tab it's set relative to.
				integer, [max]
					Maximum distance away from a tab it's relative to. Defaults to min if not defined.
				integer, [pref]
					Preferred distance away from a tab it's relative to. Defaults to min if not defined.
				integer, [weight]
					How much weight is given to this tab (DEPENDS ON RESOLVER USED). Defaults to 1 if not defined.

			@returns
				nil
		]]

		max = max or min
		pref = pref or max/2
		weight = weight or 1

		public.tabs[axis][tag] =
		{
			min = min;
			max = max;
			weight = weight;

			tag = tag;
		}

		local relativeToTab = public.tabs[axis][relativeTo]
		if relativeTo then
			relativeToTab.relativeTab = public[axis][tag]
		end
	end

	public.registerAnchorTab = function(axis, tag, offset)
		--[[
			@description
				Register an anchor tabs

			@parameters
				string, axis
					Axis of which the new tab will be placed.
				string, tag
					The tag of the tab. Cannot conflict with already existing tags. Used to reference the tab.
				integer, offset
					The offset away from the border.

			@returns
				nil
		]]

		public.tabs[axis][tag] =
		{
			tag = tag;
			offset = offset;
			relativeTabs = {};
		}

		public.anchors[axis][tag] = public.tabs[axis][tag]
	end

	public.pokeTab = function(axis, tag)	
		--[[
			@description
				pokey tab haha

			@parameters
				string, axis
					Axis of the tab you wanna poke.
				string, tag
					Tag of the tab you wanna poke.

			@returns
				tab, tab you wanna poke
		]]

		return public.tabs[axis][tag]
	end

	public.removeTab = function(axis, tag)
		--[[
			@description
				UNSAFE: removes tab and returns the tab(s) that was relative to it.

			@parameters
				string, axis
					Axis of tab to remove.
				string, tag
					Tag of the tab to remove.

			@returns
				tab, tab that was relative to the tab removed.
		]]

		public.tab[axis][tag] = nil
		public.anchors[axis][tag] = nil
	end

	public.isSafeToRemove = function(axis, tag)
		--[[
			@description
				Is safe to remove?

			@parameters
				string, axis
					Axis of tab to test.
				string, tag
					Tag of the tab to test.

			@returns
				boolean, is safe to remove?
		]]

		local tab = public.tab[axis][tag]
		if tab.relativeTabs then
			return #tab.relativeTabs > 0
		else
			return tab.relativeTab == true
		end
	end

	public.resolveForAxis = function(axis, maxLength)
		--[[
			@description
				Resolves for the given axis.

			@parameters
				string, axis
					Axis to resolve.
			@returns
				hashmap<string, integer>
					with string being tag of tab and integer being the position.
		]]
	end

	public.resolve = function(maxSize)
		--[[
			@parameter
				vector2, maxSize

			@description
				Returns the resolved positions of all of the tabs.

			@returns
				{ x = resolveForAxis("x"); y = resolveForAxis("y") }
		]]

		return
		{
			public.resolveForAxis("x", maxSize.x);
			public.resolveForAxis("y", maxSize.x);
		}
	end

	return public
end

return { new = new }