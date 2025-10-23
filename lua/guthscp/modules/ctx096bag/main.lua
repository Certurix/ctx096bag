local MODULE = {
	name = "SCP 096 Bag",
	author = "Certurix",
	version = "1.1.0-beta",
	description = "A must-have for SCP-096, you can bag him to avoid triggering him!",
	icon = "icon16/eye.png",
	version_url = "https://raw.githubusercontent.com/Certurix/ctx096bag/main/lua/guthscp/modules/ctx096bag/main.lua",
	dependencies = {
		base = "2.0.0",
		guthscp096 = "2.0.0",
	},
	requires = {
		["server/"] = guthscp.REALMS.SERVER,
		["shared/"] = guthscp.REALMS.SHARED,
	},
}

--  config
MODULE.menu = {
	config = {
		form = {
			"Keybinds",
			{
				type = "InputKey",
				name = "Key",
				id = "key",
				desc = "Define the key used to interact with SCP-096 Bag.",
				default = KEY_E,
			},
			{
				type = "InputKey",
				name = "Secondary Key",
				id = "secondkey",
				desc = "Define the secondary key used to drag SCP-096",
				default = KEY_G,
			},
			"General",
			{
				type = "Bool",
				name = "Progress Bar",
				id = "progressbar",
				desc = "Define if the progress bar should be shown when SCP-096 is bagged.",
				default = false,
			},
			{
				type = "Bool",
				name = "Draggable",
				id = "draggable",
				desc = "Define if SCP-096 can be dragged.",
				default = false,
			},
			{
				type = "Bool",
				name = "Bag Effects",
				id = "bageffect",
				desc = "Define if the blur and post process effects should be shown when SCP-096 is bagged.",
				default = true,
			},
			{
				type = "Number",
				name = "Notification Delay",
				id = "notificationdelay",
				desc = "How long will each notification of the module will be shown",
				default = 8,
			},
			"Bag Model",
			{
				type = "String",
				name = "Model",
				id = "bagmodel",
				desc = "Define the bag model that will be shown when SCP-096 will be bagged.",
				default = "models/props_junk/MetalBucket01a.mdl",
			},
			{
				type = "Vector",
				name = "Position Offset",
				id = "bag_position_offset",
				desc = "Set the position offset for drawing the bag model",
				default = Vector( 4.0, 3.0, 5.0 ),
			},
			{
				type = "Angle",
				name = "Rotation Offset",
				id = "bag_rotation_offset",
				desc = "Set the angle offset for drawing the bag model",
				default = Angle( -15.0, 0.0, -90.0 ),
			},
			{
				type = "Number",
				name = "Model Scale",
				id = "bag_model_scale",
				desc = "Scales the bag model",
				default = 0.9,
			},
			"Bag Effects",
			{
				type = "Bool",
				name = "Blur",
				id = "blureffect",
				desc = "Define if the blur effect should be shown when SCP-096 is bagged.",
				default = true,
			},
			{
				type = "Number",
				name = "Blur Amount",
				id = "bluramount",
				desc = "Set the amount of blur effect when SCP-096 is bagged.",
				default = 6,
			},
			{
				type = "Bool",
				name = "Post process",
				id = "postprocesseffect",
				desc = "Define if the post process effect should be shown when SCP-096 is bagged.",
				default = false,
			},
			{
				type = "Number",
				name = "PP Brightness",
				id = "postprocessbrightness",
				desc = "Set the brightness of the post process effect when SCP-096 is bagged. Recommended values: between -1 and 1.",
				default = 0,
			},
			{
				type = "Number",
				name = "PP Contrast",
				id = "postprocesscontrast",
				desc = "Set the contrast of the post process effect when SCP-096 is bagged. Recommended values: between -1 and 1.",
				default = 0,
			},
			"Translation",
			{
				type = "String",
				name = "Put the bag",
				id = "textputbag",
				desc = "Configure the text that will be shown when you have the SCP-096 Bag Swep equipped and facing toward it.",
				default = "Put the bag",
			},
			{
				type = "String",
				name = "Remove the bag",
				id = "textremovebag",
				desc = "Configure the text that will be shown when you approach SCP-096 to remove the bag.",
				default = "Remove the bag",
			},
			{
				type = "String",
				name = "Already have bag",
				id = "textalreadyhavebag",
				desc = "Configure the notification that will be shown when you try to put the bag on SCP-096 but he already have it.",
				default = "SCP-096 already have a bag on his head, press E to remove it.",
			},
			{
				type = "String",
				name = "Now have bag",
				id = "textnowhavebag",
				desc = "Configure the notification that will be shown when you put the bag on SCP-096's face",
				default = "SCP-096 now have the bag on his face!",
			},
			{
				type = "String",
				name = "No longer have bag",
				id = "textnolongerhavebag",
				desc = "Configure the notification that will be shown when you remove the bag from SCP-096's face",
				default = "You have removed the bag from SCP-096's face!",
			},
			{
				type = "String",
				name = "Is Triggered",
				id = "textistriggered",
				desc = "Configure the notification that will be shown when you try to put the bag on SCP 096's face but he is triggered.",
				default = "SCP-096 has been triggered and you can't put the bag on him!",
			},
			guthscp.config.create_apply_button(),
			guthscp.config.create_reset_button(),
		},
		receive = function( form )
			guthscp.config.apply( MODULE.id, form, {
				network = true,
				save = true,
			} )
		end,
	},
	details = {
		{
			text = "CC-BY-SA",
			icon = "icon16/page_white_key.png",
		},
		"Social",
		{
			text = "Github",
			icon = "guthscp/icons/github.png",
			url = "https://github.com/Certurix/ctx096bag",
		},
		{
			text = "Steam",
			icon = "guthscp/icons/steam.png",
			url = "https://steamcommunity.com/sharedfiles/filedetails/?id=3035662778"
		},
		{
			text = "Discord/Support",
			icon = "guthscp/icons/discord.png",
			url = "https://discord.gg/vaMFXvzwqP",
		},
	},
}

--  TODO: remove if not used
function MODULE:construct()
end

function MODULE:init()
	MODULE:info("SCP-096 Bag System has been loaded!")
end

guthscp.module.hot_reload( "ctx096bag" )
return MODULE