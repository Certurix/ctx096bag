include("shared.lua")
if not guthscp then return print("[CTX096BAG]", "FATAL ERROR! GUTHSCPBASE IS NOT INSTALLED ON THE SERVER. PLEASE INSTALL THE MODULE BASED BRANCH AND RESTART YOUR SERVER. THE MODULE CAN'T BE LOADED WITHOUT IT!", "\nINSTALL IT HERE: \nhttps://github.com/Guthen/guthscpbase/tree/remaster-as-modules-based") end

local guthscp096 = guthscp.modules.guthscp096
local config = guthscp.configs.ctx096bag
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.HoldType = "duel"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
model = ClientsideModel("models/props_junk/MetalBucket01a.mdl")
model:SetNoDraw( true )

hook.Add( "PostPlayerDraw" , "ctx_096_bag_draw" , function( ply )
	if not IsValid(ply) or not ply:Alive() then return end
    if guthscp096.is_scp_096(ply) then
        if guthscp.isSCP096Bagged(ply) then -- If bagged
            -- Bag renderer
            local attach_id = ply:LookupAttachment('eyes')
            if not attach_id then return end
                    
            local attach = ply:GetAttachment(attach_id)
                    
            if not attach then return end
                    
            local pos = attach.Pos
            local ang = attach.Ang
                
            model:SetModelScale(0.8, 0)
            pos = pos + (ang:Forward() * -5) + (ang:Up() * -4) + (ang:Right() * 4)
            ang:RotateAroundAxis(ang:Forward(), -90)
                
            model:SetPos(pos)
            model:SetAngles(ang)
            model:SetModel(config.bagmodel)
            model:SetRenderOrigin(pos)
            model:SetRenderAngles(ang)
            model:SetupBones()
            model:DrawModel()
            model:SetRenderOrigin()
            model:SetRenderAngles()

        end
    end
end )
	

hook.Add( "HUDPaint", "zzz_vkxscp096:rage", function()
	local ply = LocalPlayer()
    if guthscp096.is_scp_096( ply ) then
        if guthscp.isSCP096Bagged(ply) then -- if Bagged
            //Black Screen on SCP 096 when bag equiped
            local tab = {
                ["$pp_colour_brightness"] = 0,
                ["$pp_colour_contrast"] = 0,
            }
            DrawColorModify( tab )
        end
    end
end)
local dist_sqr = 125 ^ 1.8
hook.Add("PostPlayerDraw", "ctx_096_drawhud", function(target)
    -- hud renderer when the holder of the bag have equiped it and looking SCP 096
	local angle = EyeAngles()
	angle = Angle( 0, angle.y, 0 )
	angle:RotateAroundAxis( angle:Up(), -90 )
	angle:RotateAroundAxis( angle:Forward(), 90 )

    local ply = LocalPlayer()
	local trace = LocalPlayer():GetEyeTrace()
	local pos = trace.HitPos
    local target = trace.Entity

	pos = pos + Vector( 0, 0, math.cos( CurTime() / 2 ) + 20 )
    local weapon = ply:GetActiveWeapon()
    if target:IsPlayer() and target:GetPos():DistToSqr( ply:GetPos() ) <= dist_sqr and guthscp096.is_scp_096( target ) then
        if guthscp.isSCP096Bagged(target) then
            if guthscp096.is_scp_096_enraged(target) then return end
            cam.Start3D2D( pos, angle, 0.1 )
            surface.SetFont( "Default" )
            local text = "["..config.key.."] "..config.textremovebag
            local tW, tH = surface.GetTextSize(text)
    
            local pad = 5
            surface.SetDrawColor( 0, 0, 0)
            surface.DrawRect( -tW / 2 - pad, -pad, tW + pad * 2, tH + pad * 2 )
            draw.SimpleText(text, "Default", -tW / 2, 0, color_white )
            cam.End3D2D()
        elseif guthscp.isSCP096Bagged(ply) and not guthscp.isSCP096Bagged(target) and ply:GetActiveWeapon():GetClass() == "ctx_096_bag" then
            cam.Start3D2D( pos, angle, 0.1 )
            surface.SetFont( "Default" )
            local text2 = "["..config.key.."] "..config.textputbag
            local tW, tH = surface.GetTextSize( text2 )

            local pad = 5
            surface.SetDrawColor( 0, 0, 0)
            surface.DrawRect( -tW / 2 - pad, -pad, tW + pad * 2, tH + pad * 2 )
            draw.SimpleText( text2, "Default", -tW / 2, 0, color_white )
            cam.End3D2D()
        end
    end
end)

-- Guthen Module Base

if guthscp then
	guthscp.spawnmenu.add_weapon( SWEP, "SCP-096 Bag" )
end
