require("fps")

-- Declaration
HPP = HPP or {}
HPP.BuildingEnts = {
	["prop_physics"] = true,
	["gmod_button"] = true,
	["gmod_cameraprop"] = true,
	["keypad"] = true,
}
HPP.ExtraEnts = {
	["ent_money"] = true,
	["prop_door_rotating"] = true,
}
HPP.ExtraEnts = table.Merge(HPP.ExtraEnts, HPP.BuildingEnts)
HPP.Entity = FindMetaTable("Entity")
HPP.Phys = FindMetaTable("PhysObj")
HPP.Player = FindMetaTable("Player")

local modelBlacklist = { -- Thanks to Hexa for this
	["models/props_vehicles/tanker001a.mdl"] = true,
	["models/props_vehicles/apc001.mdl"] = true,
	["models/props_combine/combinetower001.mdl"] = true,
	["models/cranes/crane_frame.mdl"] = true,
	["models/items/item_item_crate.mdl"] = true,
	["models/props/cs_militia/silo_01.mdl"] = true,
	["models/props/cs_office/microwave.mdl"] = true,
	["models/props/de_train/biohazardtank.mdl"] = true,
	["models/props_buildings/building_002a.mdl"] = true,
	["models/props_buildings/collapsedbuilding01a.mdl"] = true,
	["models/props_buildings/project_building01.mdl"] = true,
	["models/props_buildings/row_church_fullscale.mdl"] = true,
	["models/props_c17/consolebox01a.mdl"] = true,
	["models/props_c17/oildrum001_explosive.mdl"] = true,
	["models/props_c17/paper01.mdl"] = true,
	["models/props_c17/trappropeller_engine.mdl"] = true,
	["models/props_canal/canal_bridge01.mdl"] = true,
	["models/props_canal/canal_bridge02.mdl"] = true,
	["models/props_canal/canal_bridge03a.mdl"] = true,
	["models/props_canal/canal_bridge03b.mdl"] = true,
	["models/props_combine/combine_citadel001.mdl"] = true,
	["models/props_combine/combine_mine01.mdl"] = true,
	["models/props_combine/combinetrain01.mdl"] = true,
	["models/props_combine/combinetrain02a.mdl"] = true,
	["models/props_combine/combinetrain02b.mdl"] = true,
	["models/props_combine/prison01.mdl"] = true,
	["models/props_combine/prison01c.mdl"] = true,
	["models/props_industrial/bridge.mdl"] = true,
	["models/props_junk/garbage_takeoutcarton001a.mdl"] = true,
	["models/props_junk/gascan001a.mdl"] = true,
	["models/props_junk/glassjug01.mdl"] = true,
	["models/props_junk/trashdumpster02.mdl"] = true,
	["models/props_phx/amraam.mdl"] = true,
	["models/props_phx/ball.mdl"] = true,
	["models/props_phx/cannonball.mdl"] = true,
	["models/props_phx/huge/evildisc_corp.mdl"] = true,
	["models/props_phx/misc/flakshell_big.mdl"] = true,
	["models/props_phx/misc/potato_launcher_explosive.mdl"] = true,
	["models/props_phx/mk-82.mdl"] = true,
	["models/props_phx/oildrum001_explosive.mdl"] = true,
	["models/props_phx/torpedo.mdl"] = true,
	["models/props_phx/ww2bomb.mdl"] = true,
	["models/props_wasteland/cargo_container01.mdl"] = true,
	["models/props_wasteland/cargo_container01.mdl"] = true,
	["models/props_wasteland/cargo_container01b.mdl"] = true,
	["models/props_wasteland/cargo_container01c.mdl"] = true,
	["models/props_wasteland/depot.mdl"] = true,
	["models/xqm/coastertrack/special_full_corkscrew_left_4.mdl"] = true,
	["models/props_junk/propane_tank001a.mdl"] = true,
	["models/props_c17/fountain_01.mdl"] = true,
	["models/props_trainstation/train003.mdl"] = true,
	["models/props_foliage/tree_poplar_01.mdl"] = true,
	["models/mechanics/solid_steel/i_beam2_32.mdl"] = true,
	["models/props_c17/furnituredrawer001a_chunk06.mdl"] = true,
	["models/mechanics/solid_steel/i_beam2_32.mdl"] = true,
	["models/props_phx/mechanics/slider2.mdl"] = true,
	["models/props_phx/gears/rack70.mdl"] = true,
	["models/mechanics/gears2/pinion_80t1.mdl"] = true,
	["models/nova/airboat_seat.mdl"] = true,
	["models/mechanics/robotics/a4.mdl"] = true,
	["models/mechanics/roboticslarge/claw_hub_8.mdl"] = true,
	["models/perftest/loader_static.mdl"] = true,
	["models/mechanics/robotics/e4.mdl"] = true,
	["models/mechanics/roboticslarge/e4.mdl"] = true,
	["models/perftest/rocksground01b.mdl"] = true,
	["models/mechanics/roboticslarge/g4.mdl"] = true,
	["models/mechanics/roboticslarge/e4.mdl"] = true,
	["models/mechanics/roboticslarge/j4.mdl"] = true,
	["models/props_animated_breakable/smokestack.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_01.mdl"] = true,
	["models/xqm/rails/slope_down_90.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_02.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_03.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_04.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_05.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_06.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_07.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_08.mdl"] = true,
	["models/xqm/coastertrack/special_full_loop_3.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_09.mdl"] = true,
	["models/props_animated_breakable/smokestack_gib_10.mdl"] = true,
	["models/xqm/coastertrack/special_full_corkscrew_right_4.mdl"] = true,
	["models/props_buildings/collapsedbuilding01awall.mdl"] = true,
	["models/props_buildings/collapsedbuilding02a.mdl"] = true,
	["models/props_buildings/collapsedbuilding02b.mdl"] = true,
	["models/xqm/coastertrack/special_half_corkscrew_right_4.mdl"] = true,
	["models/props_buildings/collapsedbuilding02c.mdl"] = true,
	["models/props_buildings/project_destroyedbuildings01.mdl"] = true,
	["models/props_buildings/project_building03_skybox.mdl"] = true,
	["models/props_buildings/project_building03.mdl"] = true,
	["models/props_buildings/project_building02_skybox.mdl"] = true,
	["models/props_buildings/project_building02.mdl"] = true,
	["models/props_buildings/project_building01_skybox.mdl"] = true,
	["models/props_buildings/factory_skybox001a.mdl"] = true,
	["models/xqm/coastertrack/special_full_corkscrew_right_3.mdl"] = true,
	["models/props_buildings/row_res_1_fullscale.mdl"] = true,
	["models/props_buildings/watertower_002a.mdl"] = true,
	["models/props_buildings/watertower_001c.mdl"] = true,
	["models/props_buildings/watertower_001a.mdl"] = true,
	["models/props_buildings/short_building001a.mdl"] = true,
	["models/props_buildings/row_res_2_fullscale.mdl"] = true,
	["models/props_buildings/row_res_2_ascend_fullscale.mdl"] = true,
	["models/xqm/coastertrack/special_full_corkscrew_left_2.mdl"] = true,
	["models/props_canal/generator01.mdl"] = true,
	["models/props_canal/generator02.mdl"] = true,
	["models/props_canal/locks_large.mdl"] = true,
	["models/props_canal/locks_large_b.mdl"] = true,
	["models/props_canal/locks_small.mdl"] = true,
	["models/props_canal/locks_small_b.mdl"] = true,
	["models/xqm/coastertrack/special_half_corkscrew_right_4.mdl"] = true,
	["models/props_canal/canal_bars001.mdl"] = true,
	["models/props_trainstation/train003.mdl"] = true,
	["models/props_canal/canal_bridge04.mdl"] = true,
	["models/props_canal/pipe_bracket001.mdl"] = true,
	["models/props_canal/canal_bridge_railing_lamps.mdl"] = true,
	["models/props_canal/canal_bridge_railing02.mdl"] = true,
	["models/props_canal/canal_bridge_railing01.mdl"] = true,
	["models/xqm/coastertrack/special_half_corkscrew_right_3.mdl"] = true,
	["models/props_canal/winch01.mdl"] = true,
	["models/props_canal/rock_riverbed01c.mdl"] = true,
	["models/props_canal/rock_riverbed01d.mdl"] = true,
	["models/props_canal/rock_riverbed02a.mdl"] = true,
	["models/props_canal/rock_riverbed02b.mdl"] = true,
	["models/props_canal/winch02c.mdl"] = true,
	["models/props_canal/winch02d.mdl"] = true,
	["models/props_canal/rock_riverbed01b.mdl"] = true,
	["models/props_canal/refinery_04.mdl"] = true,
	["models/props_canal/refinery_05.mdl"] = true,
	["models/xqm/rails/twist_90_left.mdl"] = true,
	["models/props_canal/canal_bars001.mdl"] = true,
	["models/props_canal/bridge_pillar02.mdl"] = true,
	["models/xqm/rails/loop_right.mdl"] = true,
	["models/props_citizen_tech/windmill_blade002a.mdl"] = true,
	["models/props_citizen_tech/till001a_base01.mdl"] = true,
	["models/props_citizen_tech/steamengine001a.mdl"] = true,
	["models/props_citizen_tech/guillotine001a_base01.mdl"] = true,
	["models/props_citizen_tech/firetrap_gashose01c.mdl"] = true,
	["models/props_citizen_tech/firetrap_gashose01b.mdl"] = true,
	["models/props_citizen_tech/firetrap_button01a.mdl"] = true,
	["models/props_citizen_tech/windmill_blade004a.mdl"] = true,
	["models/props_phx/misc/potato_launcher_chamber.mdl"] = true,
	["models/props_combine/combine_train02a.mdl"] = true,
}

local function PlayerSpawnProp(ply, model)
	local escapedModel = model:lower():gsub("\\","/"):gsub("//", "/"):Trim()

	if modelBlacklist[escapedModel] then
		aprint(Color(240,0,0), "Blacklist | ", ply, "That model is blacklisted.")
		return false
	end
end
hook.Add("PlayerSpawnProp", "propshit", PlayerSpawnProp)

--[[
	<-- Functions -->
]]--

-- Entity based
function HPP.Ghost(self) -- Ghosting the entities
	if self.ghosted then return end
	if self:IsPlayer() then return end

	local col = self:GetColor()

	if col.a ~= 245 then
		self.oldColor = self:GetColor()
	end
	if self:GetClass() == "prop_physics" and self:GetRenderMode() ~= RENDERMODE_TRANSALPHA then
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
	end

	self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
	self:SetColor(Color(col.r, col.g, col.b, 245))
	self.ghosted = true
end
function HPP.Unghost(self) -- Unghosting the entities
	if not self.ghosted then return end
	if self:IsPlayer() then return end

	if self.oldColor then
		self:SetColor(self.oldColor)
	end
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.ghosted = false
end
function HPP.CanUnghost(self)
	local PObj = self:GetPhysicsObject()

	if IsValid(PObj) and !self:IsVehicle() then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), PObj:GetVolume() / 10000 + 20 ) ) do
			if v:IsPlayer() then
				return false
			end
		end
	end
	return true
end

-- Server is lagging a bit, try to reduce that
function HPP.DeLag()
    if aprint then
	   aprint(Color(255, 0, 0), "HPP | ", {"root", "superadmin"}, "De-lagging server.")
    end
	for k, v in pairs(ents.GetAll()) do
		if HPP.ExtraEnts[v:GetClass()] then

			local pobj = v:GetPhysicsObject()
			if IsValid(pobj) then
				pobj:EnableMotion(false)
			end

		end
	end
end

-- Server is dying, try to save it!
function HPP.StopLag()
    if aprint then
        aprint(Color(255, 0, 0), "HPP | ", nil, "The server was lagging so all entities have been frozen.")
        aprint(Color(255, 0, 0), "HPP | ", {"root", "superadmin", "headadmin", "admin", "mod"}, "If this keeps occuring someone may be trying to crash the server.")
    end
	for k, v in pairs(ents.GetAll()) do

		local pobj = v:GetPhysicsObject()
		if IsValid(pobj) then
			pobj:EnableMotion(false)
		end

	end
end

--[[
	<-- Meta-Functions -->
]]--

-- Entity meta funcs
function HPP.Entity:Ghost()
	return HPP.Ghost(self)
end
function HPP.Entity:Unghost()
	return HPP.Ghost(self)
end
function HPP.Entity:GetPlayerOwner()
	return HPP.GetPlayerOwner(self)
end

--[[
	<-- Hooking into what we need -->
]]--

hook.Add("OnPhysgunReload","HPP.OnPhysgunReload",function(_, ply)
    return false
end)

-- Work out when the server is lagging
hook.Add("Tick", "HPP.Tick", function() -- tok dont stop make it pop
	local systime = SysTime()
	if HPP.Delay and HPP.Delay > systime then return end

	local realframetime = engine.RealFrameTime()
	if realframetime >= 0.5 then -- We're seriously lagging
		if !HPP.ClearCheck then
			HPP.StopLag()
		else
			HPP.DeLag()
		end
		HPP.ClearCheck = false
	elseif realframetime >= 0.3 then -- We're just lagging a bit
		if !HPP.ClearCheck then
			HPP.DeLag()
		end
		HPP.ClearCheck = false
	else
		HPP.ClearCheck = true
	end

	HPP.Delay = systime + 3
end)

hook.Add( "CanTool", "HPP.CanTool", function( ply, tr, tool ) -- Stop people fucking with tools
    -- Advanced Dupe model scale exploit
	local dupetab =
		(tool == 'adv_duplicator' and ply:GetActiveWeapon():GetToolObject().Entities) or
		(tool == 'advdupe2' and ply.AdvDupe2 and ply.AdvDupe2.Entities) or
		(tool == 'duplicator' and ply.CurrentDupe and ply.CurrentDupe.Entities)

	if dupetab then
		for k, v in pairs(dupetab) do
			if !v.ModelScale then continue end
			if v.ModelScale > 10 then
				return false
			end
			v.ModelScale = 1
		end
	end

	if tool:lower() == "material" then -- blackscreen exploit
        local tool = ply:GetActiveWeapon():GetToolObject()
	local mat = string.lower(tool:GetClientInfo("override"))	
        if string.StartWith(mat, "pp/") and string.EndsWith(mat, "/copy") then -- blackscreen exploit
            return false
        end
    end
end)

-- Code below this stops collisions
hook.Add("PlayerSpawnedProp", "HPP.PlayerSpawnedProp", function(ply, _, ent)
	local mat = ent:GetMaterial()
	if string.StartWith(mat, "pp/") and string.EndsWith(mat, "/copy") then -- blackscreen exploit
        ent:Remove()
    end

	ent:SetCustomCollisionCheck(true)
	ent:CollisionRulesChanged()
    ent:GetPhysicsObject():EnableMotion(false)
end)

hook.Add("ShouldCollide", "HPP.ShouldCollide" , function(e1 , e2) -- Stop shit colliding which doesn't need to\
    if HPP.ExtraEnts[e1:GetClass()] and HPP.ExtraEnts[e2:GetClass()] then
        return false
    end
end)

hook.Add( "PhysgunPickup", "HPP.PhysgunPickup", function( ply, ent )
	if ent:IsPlayer() then return end
	local cantouch = ent:CPPICanPhysgun(ply)
	if cantouch then
		HPP.Ghost(ent)
		if ent:IsConstrained() then
			local tbl = constraint.GetAllConstrainedEntities(ent)
			for k, v in pairs(tbl) do
				if ent == k then continue end
				HPP.Ghost(k)
			end
		end
	else
		return false
	end
end)

hook.Add("PhysgunDrop", "HPP.PhysgunDrop", function(ply, ent)
    if HPP.CanUnghost(ent, ply) then
        HPP.Unghost(ent)
        if ent:IsConstrained() then
			local tbl = constraint.GetAllConstrainedEntities(ent)
			for k, v in pairs(tbl) do
				if ent == k then continue end
				if HPP.CanUnghost(k, ply) then
					HPP.Unghost(k)
				end
			end
		end
    end
end)

--[[
	<-- Overwriting the default setposition functions and clamping them.
	This shouldn't be needed however it could stop strange stuff happening. -->
]]--
if (HPP.Entity.SetRealPos == nil) and (HPP.Phys.SetRealPos == nil) then
	HPP.Entity.SetRealPos = HPP.Entity.SetPos
	HPP.Phys.SetRealPos = HPP.Phys.SetPos
end

local Clamp = math.Clamp
function HPP.Entity.SetPos(ent, pos)
    pos.x = Clamp(pos.x, -20000, 20000)
    pos.y = Clamp(pos.y, -20000, 20000)
    pos.z = Clamp(pos.z, -20000, 20000)
    HPP.Entity.SetRealPos(ent, pos) -- called with pos being nil? wtf
end
function HPP.Phys.SetPos(phys, pos)
    pos.x = Clamp(pos.x, -20000, 20000)
    pos.y = Clamp(pos.y, -20000, 20000)
    pos.z = Clamp(pos.z, -20000, 20000)
    HPP.Phys.SetRealPos(phys, pos)
end



-- Let everyone know we've loaded
print(" > Crident anti-crash loaded")
