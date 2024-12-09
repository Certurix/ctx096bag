include("shared.lua")
if not guthscp then return print("[CTX096BAG]", "FATAL ERROR! GUTHSCPBASE IS NOT INSTALLED ON THE SERVER. PLEASE INSTALL THE MODULE BASED BRANCH AND RESTART YOUR SERVER. THE MODULE CAN'T BE LOADED WITHOUT IT!", "\nINSTALL IT HERE: \nhttps://github.com/Guthen/guthscpbase/tree/remaster-as-modules-based") end
local guthscp096 = guthscp.modules.guthscp096
local ctx096bag = guthscp.modules.ctx096bag
local config = guthscp.configs.ctx096bag
local dist_sqr = 125 ^ 1.8
progress = 0
model = ClientsideModel("models/props_junk/MetalBucket01a.mdl")
model:SetNoDraw(true)
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
SWEP.WorldModel = model
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
hook.Add("PostPlayerDraw", "ctx_096_bag_draw", function(ply)
    if not IsValid(ply) or not ply:Alive() then return end
    if guthscp096.is_scp_096(ply) and ctx096bag.is_scp_096_bagged(ply) then
        -- Bag renderer
        local attach_id = ply:LookupAttachment("eyes")
        if not attach_id then return end
        local attach = ply:GetAttachment(attach_id)
        if not attach then return end
        local ang = attach.Ang + config.bag_rotation_offset
        local pos = attach.Pos - ang:Forward() * config.bag_position_offset.x - ang:Right() * config.bag_position_offset.y - ang:Up() * config.bag_position_offset.z
        model:SetModelScale(config.bag_model_scale, 0)
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
end)

local function ctx096bag_progressbar()
    hook.Add("HUDPaint", "ctx_096_bag_progress", function()
        local ply = LocalPlayer()
        if config.progressbar then
            if guthscp096.is_scp_096(ply) and ctx096bag.is_scp_096_bagged(ply) then
                local screenWidth, screenHeight = ScrW(), ScrH()
                local barWidth, barHeight = 200, 20
                local barX, barY = screenWidth / 2 - barWidth / 2, screenHeight - 100
                surface.SetDrawColor(255, 255, 255)
                surface.DrawRect(barX, barY, barWidth, barHeight)
                local progressWidth = barWidth * progress
                surface.SetDrawColor(config.progressbar_color)
                surface.DrawRect(barX, barY, progressWidth, barHeight)
                if progress >= 0 and progress < 1 then progress = progress - FrameTime() * config.progressbar_speed end
                if progress >= 1 and progress > 0 then
                    progress = 0
                    hook.Remove("HUDPaint", "ctx_096_bag_progress")
                    net.Start("ctx_096_bag::destroyed_bag")
                    net.SendToServer()
                end
            else
                progress = 0
            end
        end
    end)
end

hook.Add("HUDPaint", "ctx_096_bag_effects", function()
    local ply = LocalPlayer()
    if guthscp096.is_scp_096(ply) and ctx096bag.is_scp_096_bagged(ply) then
        -- Black Screen on SCP 096 when bag equiped
        local tab = {
            ["$pp_colour_brightness"] = 0,
            ["$pp_colour_contrast"] = 0,
        }

        DrawColorModify(tab)
        ctx096bag_progressbar()
    end
end)

hook.Add("KeyPress", "ctx_096_bag_keypress", function(ply, key)
    if guthscp096.is_scp_096(ply) and key == IN_USE then
        if input.IsKeyDown(KEY_E) then
            progress = progress + config.progressbar_threshold
        else
            progress = 0
        end
    end
end)

hook.Add("PostPlayerDraw", "ctx_096_drawhud", function()
    -- hud renderer when the holder of the bag have equiped it and looking SCP 096
    local angle = EyeAngles()
    angle = Angle(0, angle.y, 0)
    angle:RotateAroundAxis(angle:Up(), -90)
    angle:RotateAroundAxis(angle:Forward(), 90)
    local ply = LocalPlayer()
    local trace = LocalPlayer():GetEyeTrace()
    local pos = trace.HitPos
    local target = trace.Entity
    local key = string.upper(input.GetKeyName(config.key))
    pos = pos + Vector(0, 0, math.cos(CurTime() / 2) + 20)
    if target:IsPlayer() and target:GetPos():DistToSqr(ply:GetPos()) <= dist_sqr and guthscp096.is_scp_096(target) then
        if ctx096bag.is_scp_096_bagged(target) then
            if guthscp096.is_scp_096_enraged(target) then return end
            cam.Start3D2D(pos, angle, 0.1)
            surface.SetFont("Default")
            local text = "[" .. key .. "] " .. config.textremovebag
            local tW, tH = surface.GetTextSize(text)
            local pad = 5
            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(-tW / 2 - pad, -pad, tW + pad * 2, tH + pad * 2)
            draw.SimpleText(text, "Default", -tW / 2, 0, color_white)
            cam.End3D2D()
        elseif ctx096bag.is_scp_096_bagged(ply) and not ctx096bag.is_scp_096_bagged(target) and ply:GetActiveWeapon():GetClass() == "ctx_096_bag" then
            cam.Start3D2D(pos, angle, 0.1)
            surface.SetFont("Default")
            local text2 = "[" .. key .. "] " .. config.textputbag
            local tW, tH = surface.GetTextSize(text2)
            local pad = 5
            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(-tW / 2 - pad, -pad, tW + pad * 2, tH + pad * 2)
            draw.SimpleText(text2, "Default", -tW / 2, 0, color_white)
            cam.End3D2D()
        end
    end
end)

-- Guthen Module Base
if guthscp then guthscp.spawnmenu.add_weapon(SWEP, "SCP-096 Bag") end