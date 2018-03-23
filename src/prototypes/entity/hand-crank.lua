require('util')

data:extend{{
	type = 'solar-panel',
	name = 'hand-crank',
	icon = '__base__/graphics/icons/solar-panel.png',
	icon_size = 32,
	flags = {'placeable-neutral', 'player-creation'},
	minable = {hardness = 0.1, mining_time = 0.2, result = 'hand-crank'},
	max_health = 40,
	corpse = 'small-remnants',
	collision_box = {{-0.92, -0.38}, {0.069, 0.57}},
	selection_box = {{-0.92, -0.38}, {0.069, 0.57}},
	energy_source =
	{
		type = 'electric',
		usage_priority = 'secondary-output'
	},
	picture =
	{
		layers =
		{
			{
				filename = '__HandCrank__/graphics/entity/hand-crank.png',
				priority = 'high',
				width = 64,
				height = 48,
				shift = util.by_pixel(0, 3),
--				hr_version = {
--					filename = '__base__/graphics/entity/solar-panel/hr-solar-panel.png',
--					priority = 'high',
--					width = 230,
--					height = 224,
--					shift = util.by_pixel(-3, 3.5),
--					scale = 0.5
--				}
			},
			{
				filename = '__HandCrank__/graphics/entity/hand-crank_shadow.png',
				priority = 'high',
				width = 64,
				height = 48,
				shift = util.by_pixel(0, 3),
				draw_as_shadow = true,
--				hr_version = {
--					filename = '__base__/graphics/entity/solar-panel/hr-solar-panel-shadow.png',
--					priority = 'high',
--					width = 220,
--					height = 180,
--					shift = util.by_pixel(9.5, 6),
--					draw_as_shadow = true,
--					scale = 0.5
--				}
			}
		}
	},
	overlay =
	{
		layers =
		{
			{
				filename = '__HandCrank__/graphics/entity/hand-crank_dark.png',
				priority = 'high',
				width = 64,
				height = 48,
				shift = util.by_pixel(0, 3),
--				hr_version = {
--					filename = '__base__/graphics/entity/solar-panel/hr-solar-panel-shadow-overlay.png',
--					priority = 'high',
--					width = 214,
--					height = 180,
--					shift = util.by_pixel(10.5, 6),
--					scale = 0.5
--				}
			}
		}
	},
	vehicle_impact_sound = {
		filename = '__base__/sound/car-metal-impact.ogg',
		volume = 0.4
	},
	production = '20kW'
}}