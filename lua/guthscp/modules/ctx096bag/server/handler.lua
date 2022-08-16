if guthscp then
    if guthscp.configs.bagmodel == nil then
        guthscp.error("[SCP 096 Module]", "Warning, the SCP-096 Bag Model is not setup correctly, a backup model has been replaced to avoid any errors! Please review your configuration file.")
    end
end

hook.Add( "vkxscp096:should_trigger", "vkxscp096:ignore_bag", function( target, ply )
	if ply:HasWeapon("ctx_096_bag") then
		return false
	end
end )
local dist_sqr = 125 ^ 2
hook.Add( "PlayerUse", "ctxscp096:UseBag", function( ply, target )
	print( ply, target )
	if target:IsPlayer() and target:GetPos():DistToSqr( ply:GetPos() ) <= dist_sqr and guthscp.isSCP096( target ) then
		if target:HasWeapon("ctx_096_bag") then
			DarkRP.notify(ply, NOTIFY_GENERIC, 8, "Vous avez enlevé le sac de SCP 096 !") target:StripWeapon("ctx_096_bag") ply:Give("ctx_096_bag")
	   end
	end
end )