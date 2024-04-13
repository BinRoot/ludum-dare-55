extends Node2D

@onready var map_ref_rect: ReferenceRect = $MapReferenceRect
@onready var line_for_power_core_distance = $LineHolder/PowerCoreLine2D
@onready var line_holder: Node2D = $LineHolder
@onready var astar_grid = AStarGrid2D.new()

var selected_box

var sockets = []


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

func get_nearest_socket(reference_position: Vector2):
	var nearest_socket
	for socket in sockets:
		if not socket.get_box().is_powered:
			continue
		if socket.consumed_by != null:
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

func _physics_process(_delta):
	if selected_box != null:
		selected_box.position = get_global_mouse_position()
		var nearest_socket = get_nearest_socket(selected_box.global_position)
		if nearest_socket != null:
			var start_position = get_available_input(selected_box).global_position
			var target_position = nearest_socket.global_position
			var path = get_path_from_positions(start_position, target_position)
			line_for_power_core_distance.points = path



static func get_available_input(box):
	for input in box.inputs:
		if input.consumed_by == null:
			return input


func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and selected_box != null:
			var nearest_socket = get_nearest_socket(selected_box.global_position)
			if nearest_socket != null:
				var line2d = Line2D.new()
				var start_position = get_available_input(selected_box).global_position
				var target_position = nearest_socket.global_position
				var path = get_path_from_positions(start_position, target_position)
				if path.size() > 0:
					line2d.add_point
					line2d.points = path
					line_holder.add_child(line2d)
					get_available_input(selected_box).consumed_by = nearest_socket.get_box()
					nearest_socket.consumed_by = selected_box
			line_for_power_core_distance.points = []
			refresh_sockets_array()
			selected_box.is_in_play = true
			selected_box = null
			refresh_grid()



func _on_deck_box_selected(card_res: Resource):
	selected_box = card_res.instantiate()
	add_child(selected_box)
	selected_box.connect("power_core_clicked", _on_power_core_clicked)

func _on_power_core_clicked(selected_pc):
	var nearest_socket = get_nearest_socket(selected_pc.global_position)
	if nearest_socket != null:
		var line2d = Line2D.new()
		var start_position = selected_pc.global_position
		var target_position = nearest_socket.global_position
		var path = get_path_from_positions(start_position, target_position)
		if path.size() > 0:
			line2d.points = path
			line_holder.add_child(line2d)
			selected_pc.consumed_by = nearest_socket.get_box()
			nearest_socket.consumed_by = selected_pc.get_box()
