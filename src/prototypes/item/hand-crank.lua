data:extend{
	{
		type = 'item',
		name = 'hand-crank',
		icon = '__base__/graphics/icons/substation.png', -- TODO
		icon_size = 32,
		flags = {'goes-to-quickbar'},
		subgroup = 'energy',
		place_result='hand-crank',
		order = 'b[energy]-d[hand-crank]',
		stack_size = 10,
	}
}
