local MODULE = {
	name = "SCP 096 Bag",
	author = "Certurix",
	version = "1.0.0",
	description = "A must-have for SCP-096, you can bag him to avoid triggering him!",
	icon = "icon16/eye.png",
	version_url = "https://raw.githubusercontent.com/Certurix/ctx096bag/main/lua/guthscp/modules/ctx096bag/main.lua",
	dependencies = {
		base = "2.0.0",
		vkxscp096 = "2.0.0",
	},
}
--  config
MODULE.config = {
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
		guthscp.config.create_apply_button(),
	},
	receive = function( form )
		guthscp.config.apply( MODULE.id, form, {
			network = true,
			save = true,
		} )
	end,
}

--  TODO: remove if not used
function MODULE:construct()
end

function MODULE:init()
	print("SCP-096 Bag Module has ben loaded!")
end

guthscp.module.hot_reload( "ctx096bag" )
return MODULE
