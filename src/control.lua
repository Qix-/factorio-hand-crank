local energy_10kw = 166.666666666666
local current_cranks = {}

script.on_event(defines.events.on_tick, function()
	for _, crank in ipairs(current_cranks) do
		if crank.valid then
			crank.power_production = 0
		end
	end
	current_cranks = {}

	for _, player in pairs(game.players) do
		if player.walking_state.walking and player.walking_state.direction == defines.direction.north then
			local position = player.position
			position.y = position.y - 1.0
			local crank = player.surface.find_entity('hand-crank', position)
			if crank then
				crank.power_production = energy_10kw
				table.insert(current_cranks, crank)
			end
		end
	end
end)
