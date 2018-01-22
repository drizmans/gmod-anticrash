--[[
	Aero Print:
	My chat print lib, keeps things consistent and reduces the amount of net messages.
]]--
if aprint then Error("Crident Anti-Crash might not work as expected; aprint already exists. You can probably ignore this.") return end
util.AddNetworkString("aprint")

local function addText(col, str1, ply, str)
	local packet = util.TableToJSON({col, str1, str})
	net.Start("aprint")
		net.WriteString(packet)
	net.Send(ply)
end

local function recType(input)
	if isstring(input) then
		local output = {}

		for k, v in pairs(player.GetAll()) do
			if v:GetUserGroup() == input then
				output[v] = true
			end
		end

		return output
	elseif input.IsPlayer and input:IsPlayer() then
		local output = {}

		output[input] = true
		return output
	end

	return false
end

function aprint(col, str1, rec, str)
	if istable(rec) then
		local rec2 = {}

		for k, v in pairs(rec) do
			local rec = recType(v)

			if istable(rec) then
				for k in pairs(rec) do
					rec2[k] = true
				end
			elseif rec then
				rec2[rec] = true
			end
		end

		for k, v in pairs(rec2) do
			addText(col, str1, k, str)
		end
	elseif isstring(rec) then
		rec = recType(rec)

		for k, v in pairs(rec) do
			addText(col, str1, k, str)
		end
	elseif IsEntity(rec) and rec:IsPlayer() then
		addText(col, str1, rec, str)
	elseif rec then
		for k, v in pairs(player.GetAll()) do
			addText(col, str1, v, str)
		end
	end
end
