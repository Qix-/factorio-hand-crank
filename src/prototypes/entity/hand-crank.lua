data:extend{{
	type = 'electric-energy-interface',
	name = 'hand-crank',
	icon = '__base__/graphics/icons/accumulator.png',
	icon_size = 32,
	flags = {'placeable-neutral', 'player-creation'},
	minable = {hardness = 0.1, mining_time = 0.2, result = 'hand-crank'},
	max_health = 40,
	corpse = 'small-remnants',
	collision_box = {{-0.78, -0.62}, {0.77, 0.48}},
	selection_box = {{-0.78, -0.62}, {0.77, 0.48}},
	enable_gui = true,
	allow_copy_paste = false,
	energy_source =
	{
		type = 'electric',
		usage_priority = 'primary-output',
		render_no_power_icon = false,
		render_no_network_icon = true,
		buffer_capacity = '10kW',
		input_flow_limit = '0kW',
		output_flow_limit = '10kW'
	},
	energy_production = '0kW',
	energy_usage = "0kW",
	animation =
	{
		layers =
		{
			{
				filename = '__HandCrank__/graphics/entity/hand-crank.png',
				priority = 'extra-high',
				width = 96,
				height = 48,
				shift = {0.6, 0},
				line_length = 1,
				frame_count = 24,
				animation_speed = 0.004,
				run_mode = 'forward'
			},
			{
				filename = '__HandCrank__/graphics/entity/hand-crank_dark.png',
				priority = 'extra-high',
				width = 96,
				height = 48,
				shift = {0.6, 0},
				frame_count = 24,
				line_length = 1,
				animation_speed = 0.004,
				draw_as_shadow = true,
				run_mode = 'forward'
			},
			{
				filename = '__HandCrank__/graphics/entity/hand-crank_shadow.png',
				priority = 'extra-high',
				width = 96,
				height = 48,
				shift = {0.6, 0},
				line_length = 1,
				frame_count = 24,
				animation_speed = 0.004,
				run_mode = 'forward'
			}
		}
	},
	vehicle_impact_sound = {
		filename = '__base__/sound/car-metal-impact.ogg',
		volume = 0.4
	}
}}
