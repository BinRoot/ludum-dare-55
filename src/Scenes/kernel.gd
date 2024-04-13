extends Node2D

@onready var map_ref_rect: ReferenceRect = $MapReferenceRect
@onready var line_for_power_core_distance = $LineHolder/PowerCoreLine2D
@onready var line_holder: Node2D = $LineHolder
var selected_box

var sockets = []

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_sockets_array()

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

func _physics_process(_delta):
	if selected_box != null:
		selected_box.position = get_global_mouse_position()
		var nearest_socket = get_nearest_socket(selected_box.global_position)
		if nearest_socket != null:
			line_for_power_core_distance.points = [get_available_input(selected_box).global_position, nearest_socket.global_position]
		else:
			print('nearest_socket is null')

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
				line2d.points = [get_available_input(selected_box).global_position, nearest_socket.global_position]
				line_holder.add_child(line2d)
				get_available_input(selected_box).consumed_by = nearest_socket.get_box()
				nearest_socket.consumed_by = selected_box
			line_for_power_core_distance.points = []
			refresh_sockets_array()
			selected_box.is_in_play = true
			selected_box = null



func _on_deck_box_selected(card_res: Resource):
	selected_box = card_res.instantiate()
	add_child(selected_box)
	selected_box.connect("power_core_clicked", _on_power_core_clicked)	
	
func _on_power_core_clicked(selected_pc):
	var nearest_socket = get_nearest_socket(selected_pc.global_position)
	if nearest_socket != null:
		var line2d = Line2D.new()
		line2d.points = [selected_pc.global_position, nearest_socket.global_position]
		line_holder.add_child(line2d)
		selected_pc.consumed_by = nearest_socket.get_box()
		nearest_socket.consumed_by = selected_pc.get_box()
