local ctx096bag = guthscp.modules.ctx096bag
function ctx096bag.is_scp_096_bagged(ply)
	if IsValid(ply:GetWeapon("ctx_096_bag")) then return true end
end

function ctx096bag.is_scp_096_dragged(ply)
	return ply:GetNW2Bool("ctx_096_bag", false)
end

function ctx096bag.notification(ply, notify, length, text)
	if DarkRP then
		DarkRP.notify(ply, notify, length, text)
	else
		ply:ChatPrint(text)
	end
end