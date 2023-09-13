local ctx096bag = guthscp.modules.ctx096bag

function ctx096bag.is_scp_096_bagged( ply )
    if IsValid(ply:GetWeapon("ctx_096_bag")) then
		return true
	end
end
