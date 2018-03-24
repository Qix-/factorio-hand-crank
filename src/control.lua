local energy_10kw = 166.666666666666
local energy_cooldown = 0.95
local current_cranks = {}

script.on_event(defines.events.on_tick, function()
	local new_cranks = {}
	for _, crank in pairs(current_cranks) do
		if crank.valid then
			crank.power_production = crank.power_production * energy_cooldown - (1 - energy_cooldown)
			if crank.power_production <= 0.05 then
				crank.power_production = 0
			else
				new_cranks[crank.unit_number] = crank
			end
		end
	end
	current_cranks = new_cranks

	for _, player in pairs(game.players) do
		if player.walking_state.walking and player.walking_state.direction == defines.direction.north then
			local position = player.position
			position.y = position.y - 1.0
			local crank = player.surface.find_entity('hand-crank', position)
			if crank then
				crank.power_production = energy_10kw
				current_cranks[crank.unit_number] = crank
			end
		end
	end
end)
