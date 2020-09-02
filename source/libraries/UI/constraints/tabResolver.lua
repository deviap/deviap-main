-- Copyright 2020 - Deviap (deviap.com)
-- Author(s): utrain, Ya

-- Constraints using tabs. Some components of this are not implemented. This is not is also not the final interface.

local function getMinMaxFromOffset(tab, offset, maxLength)
    --[[
        @description
            Returns distance to give between given offset and tab

        @parameters
        tab, tab
            The tab which the distance should be calculcated from.
        integer, offset
            The current offset away from the border of a tab.
        integer, maxLength
            The length of the current container.

        @returns
            integer, Distance to give between given offset and tab.
    ]]

    local availableSpace = (maxLength - offset) - tab.max

    return (availableSpace >= tab.max) and tab.max or tab.min
end

local function getRelativeTabs(tab, array)
    --[[
        @description
            Returns distance to give between given offset and tab

        @parameters
        tab, tab
            The tab which the relative tabs should be collected from.
        Array, array
            The array which holds the collected relative tabs.

        @returns
            Array, Collected tabs from relative tab recursion
    ]]

    local currentTabs = array or {}
    local relativeTab = tab.relativeTab

    if relativeTab then
        table.insert(currentTabs, relativeTab)
        return getRelativeTabs(relativeTab, currentTabs)
    end

    return currentTabs
end

local new = function()
    local public = {}
    public.tabs = { x = {}; y = {} }

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
            if relativeToTab.relativeTabs then
                table.insert(relativeToTab.relativeTabs, public.tabs[axis][tag])
            else
                relativeToTab.relativeTab = public.tabs[axis][tag]
            end
        end

        return public.tabs[axis][tag]
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

        return public.tabs[axis][tag]
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

        local axis = public.tabs[axis]
        local tabDict = {}

        for _, tab in pairs(axis) do
            local relativeTabs = tab.relativeTabs

            if relativeTabs then
                for _, relativeTab in pairs(relativeTabs) do
                    local offset = tab.offset
                    tabDict[tab.tag] = offset

                    local distance = getMinMaxFromOffset(relativeTab, offset, maxLength)
                    local lastOffset = offset + distance

                    tabDict[relativeTab.tag] = lastOffset

                    local relativeChildren = getRelativeTabs(relativeTab)

                    for _, relativeChild in pairs(relativeChildren) do
                        local distance = getMinMaxFromOffset(relativeTab, lastOffset, maxLength)
                        local lastOffset = lastOffset + distance

                        tabDict[relativeChild.tag] = lastOffset
                    end
                end
            end
        end

        return tabDict
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
            public.resolveForAxis("y", maxSize.y);
        }
    end

    return public
end

return new