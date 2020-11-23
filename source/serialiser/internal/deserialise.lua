---------------------------------------------------------------
-- Copyright 2020 Deviap (https://deviap.com/)               --
---------------------------------------------------------------
-- Made available under the MIT License:                     --
-- https://github.com/deviap/deviap-main/blob/master/LICENSE --
---------------------------------------------------------------
--
local shared = require("devgit:source/serialiser/internal/shared.lua")

local function deserialiseObject(serialised, realObject)
	local classInfo = core.reflection:getClassReflection(serialised.className)
	if realObject and realObject.className ~= serialised.className then
		return error("Invalid real object passed", 2)
	end

	if not classInfo then
		warn("The requested class (" .. serialised.className .. ") does not exist, we'll skip it...")
		return nil
	elseif not classInfo.constructable and not realObject then
		warn("This object is not of a constructable class (" .. serialised.className .. "), we'll skip it...")
		return nil
	end

	if not realObject then
		realObject = core.construct(serialised.className)
	end

	for k, v in pairs(serialised) do
		local prop = classInfo.properties[k]
		if prop and prop.hasSetter then
			realObject[k] = v
		elseif prop and type(realObject[k]) == "tevObj" then
			deserialiseObject(v, realObject[k])
		end
	end

	if serialised.children then
		for _, v in pairs(serialised.children) do
			local child = deserialiseObject(v)
			if child then
				child.parent = realObject
			end
		end
	end

	return realObject
end

return function(serialised, realObject)
	local infoAndObject = core.json:decode(serialised)
	if shared.version ~= infoAndObject.serialiserVersion then
		return error("Serialiser version mismatch", 2)
	end

	if infoAndObject.object.className == "scene" and not realObject then
		realObject = core.scene
	end

	return deserialiseObject(infoAndObject.object, realObject)
end
