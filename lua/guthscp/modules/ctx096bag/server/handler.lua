local guthscp096 = guthscp.modules.guthscp096
hook.Add( "guthscp096:should_trigger", "guthscp096:ignore_bag", function( target, ply )
	if guthscp.isSCP096Bagged(ply) then
		return false
	end
end )
local dist_sqr = 125 ^ 2
local function UseBag(ply, button)
	local config = guthscp.configs.ctx096bag
	if ( not IsFirstTimePredicted() ) then return end
	if button == _G["KEY_" .. config.key] then
		local cur_time = CurTime()
		if ( ply.LastUse or cur_time ) > cur_time then
			return
		end
		local trace = ply:GetEyeTrace()
		local target = trace.Entity
		ply.LastUse = cur_time + 2
		local tool = ply:GetActiveWeapon():GetClass()
		if not guthscp096.is_scp_096_enraged( target ) then
			if target:IsPlayer() and target:GetPos():DistToSqr( ply:GetPos() ) <= dist_sqr and guthscp096.is_scp_096( target ) then
				if guthscp.isSCP096Bagged(target) then
					if tool == "ctx_096_bag" then -- If the player have SCP 096 Bag equipped
						return DarkRP.notify(ply, NOTIFY_ERROR, 8, config.textalreadyhavebag)
					else
						DarkRP.notify(ply, NOTIFY_GENERIC, 8, config.textnolongerhavebag) target:StripWeapon("ctx_096_bag") ply:Give("ctx_096_bag")
					end
				else
					if tool == "ctx_096_bag" then
						target:Give("ctx_096_bag")
						DarkRP.notify(ply, NOTIFY_GENERIC, 8, config.textnowhavebag)
						ply:StripWeapon("ctx_096_bag")
					end
				end
			end
		else
			DarkRP.notify(ply, NOTIFY_ERROR, 8, config.textistriggered)
		end
	end
end

hook.Add("PlayerButtonDown", "CTX_SCP096_UseBag", UseBag)