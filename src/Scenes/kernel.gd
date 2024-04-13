extends Node2D
signal out_of_sockets

@onready var map_ref_rect: ReferenceRect = $MapReferenceRect
@onready var line_for_power_core_distance = $LineHolder/PowerCoreLine2D
@onready var line_holder: Node2D = $LineHolder
@onready var astar_grid = AStarGrid2D.new()
@onready var line_gradient: Gradient = Gradient.new()
@onready var game_over_checker: Timer = $GameOverChecker
@onready var summon = $BoxSummon1

var selected_box

var sockets = []

var is_player_turn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_sockets_array()
	astar_grid.region = map_ref_rect.get_rect()
	astar_grid.cell_size = Vector2(32, 32)
	astar_grid.update()
	refresh_grid()


func refresh_grid():
	for poly2d in get_tree().get_nodes_in_group("is_solid"):
		var p2d: Polygon2D = poly2d
		var rect_top_left_id = get_grid_coord_from_position(p2d.global_position + p2d.polygon[0])
		var rect_bot_right_id = get_grid_coord_from_position(p2d.global_position + p2d.polygon[1])
		var solid_obj = Rect2i(rect_top_left_id, rect_bot_right_id - rect_top_left_id)
		astar_grid.fill_weight_scale_region(solid_obj, 2)

func refresh_sockets_array():
	sockets = get_tree().get_nodes_in_group('socket')
	game_over_checker.start()


func get_nearest_socket(reference_position: Vector2, player_id: Globals.PlayerID):
	var nearest_socket
	for socket in sockets:
		var socket_weak_ref = weakref(socket)
		if !socket_weak_ref.get_ref():
			continue
		var box = socket.get_box()
		if not box.is_powered:
			continue
		if socket.consumed_by != null:
			continue
		if box.owned_by != player_id and box.owned_by != Globals.PlayerID.NEUTRAL:
			continue
		if not nearest_socket:
			nearest_socket = socket
		else:
			if socket.global_position.distance_to(reference_position) < nearest_socket.global_position.distance_to(reference_position):
				nearest_socket = socket
	return nearest_socket

func get_grid_coord_from_position(pos: Vector2):
	var rect: Rect2i = map_ref_rect.get_rect()
	var cell_size: Vector2 = astar_grid.cell_size
	var coord = Vector2i()
	coord.x = int((pos.x - rect.position.x) / cell_size.x)
	coord.y = int((pos.y - rect.position.y) / cell_size.y)
	return coord

func get_path_from_positions(start_position: Vector2, target_position: Vector2):
	var this_box: Rect2 = Rect2(get_grid_coord_from_position(start_position - astar_grid.cell_size), astar_grid.cell_size * 3)
	var start_coord_id = get_grid_coord_from_position(start_position)
	var target_coord_id = get_grid_coord_from_position(target_position)
	var path = astar_grid.get_point_path(start_coord_id, target_coord_id)
	return path

func draw_path(path):
	line_for_power_core_distance.points = path
	for point_idx in range(line_gradient.get_point_count()):
		line_gradient.remove_point(point_idx)
	for path_idx in range(path.size() + 1):
		if path_idx > path.size() - Globals.params["misc"]["max_path_length"]:
			line_gradient.add_point(path_idx / float(path.size()), Color.GREEN)
		else:
			line_gradient.add_point(path_idx / float(path.size()), Color.RED)
	line_for_power_core_distance.gradient = line_gradient

func _physics_process(_delta):
	if selected_box != null:
		selected_box.position = get_global_mouse_position()
		var nearest_socket = get_nearest_socket(selected_box.global_position, Globals.PlayerID.P1)
		if nearest_socket != null:
			var start_position = get_available_input(selected_box).global_position
			var target_position = nearest_socket.global_position
			var path = get_path_from_positions(start_position, target_position)
			draw_path(path)


static func get_available_input(box):
	for input in box.inputs:
		if input.consumed_by == null:
			return input

func establish_connection(path, box, socket, player_id: Globals.PlayerID):
	var line2d = Line2D.new()
	line2d.points = path
	line_holder.add_child(line2d)
	get_available_input(box).consumed_by = socket.get_box()
	socket.consumed_by = box
	box.is_in_play = true
	refresh_sockets_array()
	box.owned_by = player_id
	selected_box = null
	refresh_grid()
	game_over_checker.start()
	if player_id == Globals.PlayerID.P1:
		player_turn_end()


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and selected_box != null:
			var nearest_socket = get_nearest_socket(selected_box.global_position, Globals.PlayerID.P1)
			if nearest_socket != null:
				var start_position = get_available_input(selected_box).global_position
				var target_position = nearest_socket.global_position
				var path = get_path_from_positions(start_position, target_position)
				if path.size() > 0 and path.size() <= Globals.params["misc"]["max_path_length"]:
					establish_connection(path, selected_box, nearest_socket, Globals.PlayerID.P1)
			line_for_power_core_distance.points = []


func _on_deck_box_selected(card_res: Resource):
	selected_box = card_res.instantiate()
	add_child(selected_box)
	selected_box.connect("power_core_clicked", _on_power_core_clicked)

func get_path_and_socket_to_power_core(selected_pc, player_id: Globals.PlayerID):
	var nearest_socket = get_nearest_socket(selected_pc.global_position, player_id)
	if nearest_socket != null:
		var start_position = selected_pc.global_position
		var target_position = nearest_socket.global_position
		var path = get_path_from_positions(start_position, target_position)
		return [path, nearest_socket]

func connect_power_core_to_socket(path, power_core, nearest_socket):
	var line2d = Line2D.new()
	line2d.points = path
	line_holder.add_child(line2d)
	power_core.consumed_by = nearest_socket.get_box()
	nearest_socket.consumed_by = power_core.get_box()
	game_over_checker.start()

func _on_power_core_clicked(selected_pc):
	var path_and_nearest_socket = get_path_and_socket_to_power_core(selected_pc, Globals.PlayerID.P1)
	if path_and_nearest_socket != null:
		var path = path_and_nearest_socket[0]
		var nearest_socket = path_and_nearest_socket[1]
		if path.size() > 0 and path.size() <= Globals.params["misc"]["max_path_length"]:
			connect_power_core_to_socket(path, selected_pc, nearest_socket)
			player_turn_end()
		else:
			draw_path(path)


func _on_game_over_checker_timeout():
	var is_socket_available = false
	for socket in sockets:
		var socket_weak_ref = weakref(socket)
		if !socket_weak_ref.get_ref():
			continue
		var box = socket.get_box()
		if (box.owned_by == Globals.PlayerID.P1 or box.owned_by == Globals.PlayerID.NEUTRAL) and box.is_powered and socket.consumed_by == null and box.is_in_play:
			is_socket_available = true
	if not is_socket_available:
		print("out of sockets")
		emit_signal("out_of_sockets")

func player_turn_end():
	print("AI Turn")
	# any open power_core to click?
	var power_cores = get_tree().get_nodes_in_group("power")
	for power_core in power_cores:
		var power_core_weak_ref = weakref(power_core)
		if !power_core_weak_ref.get_ref():
			continue
		var box = power_core.get_box()
		if power_core.consumed_by != null:
			continue
		if box.owned_by != Globals.PlayerID.COM1 and box.owned_by != Globals.PlayerID.NEUTRAL:
			continue
		if not box.is_in_play:
			continue
		# check distance
		var path_and_nearest_socket = get_path_and_socket_to_power_core(power_core, Globals.PlayerID.COM1)
		if path_and_nearest_socket != null:
			var path = path_and_nearest_socket[0]
			var nearest_socket = path_and_nearest_socket[1]
			if path.size() > 0 and path.size() <= Globals.params["misc"]["max_path_length"]:
				connect_power_core_to_socket(path, power_core, nearest_socket)
				print("connected power core")
				return

	var card_type = randi_range(0, Globals.CardTypes.values().size() - 1)
	var card_res = Globals.card_types[card_type]["resource_path"]
	var ai_selected_box = card_res.instantiate()
	add_child(ai_selected_box)
	ai_selected_box.owned_by = Globals.PlayerID.COM1
	ai_selected_box.position = Vector2(-1000, -1000)
	refresh_sockets_array()

	var max_coord = get_grid_coord_from_position(astar_grid.size)
	var grid_pos: Vector2 = astar_grid.region.position
	var grid_size: Vector2 = astar_grid.region.size
	var min_distance_to_summon = 99999
	var best_placement
	var best_path
	var best_socket

	for i in range(100):
		var rand_x_coord = randi_range(grid_pos.x, grid_pos.x + grid_size.x)
		var rand_y_coord = randi_range(grid_pos.y, grid_pos.y + grid_size.y)
		var candidate_pos = Vector2(rand_x_coord, rand_y_coord)
		#ai_selected_box.position = candidate_pos
		var socket = get_nearest_socket(candidate_pos, Globals.PlayerID.COM1)
		if socket == null:
			continue
		var grid_id_coord = get_grid_coord_from_position(Vector2(rand_x_coord, rand_y_coord))
		var path = get_path_from_positions(candidate_pos, socket.global_position)
		if path.size() == 0 or path.size() > Globals.params.misc["max_path_length"]:
			continue
		var distance_to_summon = summon.global_position.distance_to(candidate_pos)
		if distance_to_summon < min_distance_to_summon:
			min_distance_to_summon = distance_to_summon
			best_placement = candidate_pos
			best_path = path
			best_socket = socket

	if best_placement != null:
		prints('best placement: ', best_placement)
		ai_selected_box.global_position = best_placement
		establish_connection(best_path, ai_selected_box, best_socket, Globals.PlayerID.COM1)
	else:
		prints('no placement found ')
		ai_selected_box.position = Vector2(-1000, -1000)
		ai_selected_box.queue_free()

	# estimate value
	# randomly pick between top 5 options?
