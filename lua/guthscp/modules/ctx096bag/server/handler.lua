local guthscp096 = guthscp.modules.guthscp096
local ctx096bag = guthscp.modules.ctx096bag
local config = guthscp.configs.ctx096bag

util.AddNetworkString( "ctx_096_bag::destroyed_bag" )

net.Receive( "ctx_096_bag::destroyed_bag", function( len, ply )
	ply:StripWeapon( "ctx_096_bag" )
end )

hook.Add( "guthscp096:should_trigger", "guthscp096:ignore_bag", function( target, ply )
	if ctx096bag.is_scp_096_bagged(ply) then
		return false
	end
end )

local dist_sqr = 125 ^ 2

local function UseDrag(ply, key)
	if ( not IsFirstTimePredicted() ) then return end
	if not config.draggable then return end
	if key == config.secondkey then
		local cur_time = CurTime()
		if ( ply.LastUse or cur_time ) > cur_time then return end
		ply.LastUse = cur_time + 0.5

		local trace = ply:GetEyeTrace()
		local target = trace.Entity

		if not IsValid(target) then return end

		if target:IsPlayer() and target:GetPos():DistToSqr( ply:GetPos() ) <= dist_sqr and guthscp096.is_scp_096( target ) and not guthscp096.is_scp_096_enraged( target ) and ctx096bag.is_scp_096_bagged(target) then
			if not ctx096bag.is_scp_096_dragged( target ) then
				target:SetNW2Bool("ctx_096_bag", true)
				hook.Add("Think", "ctx_096_bag_drag", function()
					if target:GetPos():DistToSqr( ply:GetPos() ) >= dist_sqr then
						 target:SetNW2Bool("ctx_096_bag", false)
						 hook.Remove("Think", "ctx_096_bag_drag")
						 return end
					local direction = (target:GetPos() - ply:GetPos()):GetNormalized()
					target:SetVelocity(-direction * 20)
				end)
			else
				target:SetNW2Bool("ctx_096_bag", false)
				hook.Remove("Think", "ctx_096_bag_drag")
			end
		end
	end
end

local function Use(ply, key)
	if ( not IsFirstTimePredicted() ) then return end

	if key == config.key then
		local cur_time = CurTime()
		if ( ply.LastUse or cur_time ) > cur_time then return end
		ply.LastUse = cur_time + 2

		local trace = ply:GetEyeTrace()
		local target = trace.Entity

		local activeWeapon = ply:GetActiveWeapon()
		local tool = IsValid( activeWeapon ) and activeWeapon:GetClass()

		if not guthscp096.is_scp_096_enraged( target ) then
			if target:IsPlayer() and target:GetPos():DistToSqr( ply:GetPos() ) <= dist_sqr and guthscp096.is_scp_096( target ) then
				if ctx096bag.is_scp_096_bagged(target) then
					if tool == "ctx_096_bag" then -- If the player have SCP 096 Bag equipped
						return ctx096bag.notification(ply, NOTIFY_ERROR, 8, config.textalreadyhavebag)
					else
						ctx096bag.notification(ply, NOTIFY_GENERIC, 8, config.textnolongerhavebag) target:StripWeapon("ctx_096_bag") ply:Give("ctx_096_bag")
					end
				else
					if tool == "ctx_096_bag" then
						target:Give("ctx_096_bag")
						ctx096bag.notification(ply, NOTIFY_GENERIC, 8, config.textnowhavebag)
						ply:StripWeapon("ctx_096_bag")
					end
				end
			end
		else
			ctx096bag.notification(ply, NOTIFY_ERROR, 8, config.textistriggered)
		end
	elseif key == config.secondkey then
		UseDrag(ply, key)
	end
end

hook.Add("PlayerButtonDown", "CTX_SCP096_UseBag", Use)