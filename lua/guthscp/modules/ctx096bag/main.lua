local MODULE = {
	name = "SCP 096 Bag",
	author = "Certurix",
	version = "1.0.1-beta",
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
			{
				type = "Category",
				name = "General",
			},
			{
				type = "TextEntry",
				name = "SCP-096 Bag Model",
				id = "bagmodel",
				desc = "Define the bag model that will be shown when SCP-096 will be bagged.",
				default = "models/props_junk/MetalBucket01a.mdl",
			},
			{
				type = "TextEntry",
				name = "Key",
				id = "key",
				desc = "Define the key used to interact with SCP-096 Bag.",
				default = "E",
			},
			{
				type = "NumWang",
				name = "Notification Delay",
				id = "notificationdelay",
				desc = "How long will each notification of the module will be shown",
				default = 8,
			},
			{
				type = "Category",
				name = "Translation",
			},
			{
				type = "TextEntry",
				name = "Put the bag",
				id = "textputbag",
				desc = "Configure the text that will be shown when you have the SCP-096 Bag Swep equipped and facing toward it.",
				default = "Put the bag",
			},
			{
				type = "TextEntry",
				name = "Remove the bag",
				id = "textremovebag",
				desc = "Configure the text that will be shown when you approach SCP-096 to remove the bag.",
				default = "Remove the bag",
			},
			{
				type = "TextEntry",
				name = "Already have bag",
				id = "textalreadyhavebag",
				desc = "Configure the notification that will be shown when you try to put the bag on SCP-096 but he already have it.",
				default = "SCP-096 already have a bag on his head, press E to remove it.",
			},
			{
				type = "TextEntry",
				name = "Now have bag",
				id = "textnowhavebag",
				desc = "Configure the notification that will be shown when you put the bag on SCP-096's face",
				default = "SCP-096 now have the bag on his face!",
			},
			{
				type = "TextEntry",
				name = "No longer have bag",
				id = "textnolongerhavebag",
				desc = "Configure the notification that will be shown when you remove the bag from SCP-096's face",
				default = "You have removed the bag from SCP-096's face!",
			},
			{
				type = "TextEntry",
				name = "Is Triggered",
				id = "textistriggered",
				desc = "Configure the notification that will be shown when you try to put the bag on SCP 096's face but he is triggered.",
				default = "SCP-096 has been triggered and you can't put the bag on him!",
			},
			guthscp.config.create_apply_button(),
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
		-- {
		-- 	text = "Steam",
		-- 	icon = "guthscp/icons/steam.png",
		-- 	url = "https://steamcommunity.com/sharedfiles/filedetails/?id=2139521265"
		-- },
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