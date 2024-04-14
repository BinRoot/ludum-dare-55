extends Node2D



# parent must be a box

func _physics_process(_delta):
	# all inputs must be consumed by a powered box for this box to be powered
	get_parent().is_powered = true
	for input in get_parent().inputs:
		var input_source_box = input.consumed_by
		if input_source_box == null:
			get_parent().is_powered = false
			break
		elif not input_source_box.is_powered:
			get_parent().is_powered = false
			break
	if 'box_light' in get_parent():
			if get_parent().is_powered:
				get_parent().box_light.turn_on()
			else:
				get_parent().box_light.turn_off()
				
	if get_parent().inputs.size() > 0:
		var num_p1 = 0
		var num_com = 0
		for input in get_parent().inputs:
			if input.consumed_by != null:
				if input.consumed_by.owned_by == Globals.PlayerID.P1:
					num_p1 += 1
				elif input.consumed_by.owned_by == Globals.PlayerID.COM1:
					num_com += 1
		if num_p1 > 0 and num_com == 0:
			get_parent().owned_by = Globals.PlayerID.P1
		elif num_com > 0 and num_p1 == 0:
			get_parent().owned_by = Globals.PlayerID.COM1
		else:
			get_parent().owned_by = Globals.PlayerID.NEUTRAL
			
	if get_parent().owned_by == Globals.PlayerID.P1:
		get_parent().modulate = Color.WHITE
	elif get_parent().owned_by == Globals.PlayerID.COM1:
		get_parent().modulate = Color.LIGHT_CORAL
	else:
		get_parent().modulate = Color.LIGHT_CYAN
		
