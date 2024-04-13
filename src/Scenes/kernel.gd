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

func get_nearest_socket():
	var nearest_socket
	for socket in sockets:
		if not socket.get_box().is_powered:
			continue
		if socket.consumed_by != null:
			continue
		if not nearest_socket:
			nearest_socket = socket
		else:
			if socket.global_position.distance_to(selected_box.global_position) < nearest_socket.global_position.distance_to(selected_box.global_position):
				nearest_socket = socket
	return nearest_socket

func _physics_process(_delta):
	if selected_box != null:
		selected_box.position = get_global_mouse_position()
		var nearest_socket = get_nearest_socket()
		line_for_power_core_distance.points = [get_available_input(selected_box).global_position, nearest_socket.global_position]

static func get_available_input(box):
	for input in box.inputs:
		if input.consumed_by == null:
			return input
	

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and selected_box != null:
			var nearest_socket = get_nearest_socket()

			var line2d = Line2D.new()
			line2d.points = [get_available_input(selected_box).global_position, nearest_socket.global_position]
			line_holder.add_child(line2d)
			line_for_power_core_distance.points = []

			selected_box.inputs[0].consumed_by = nearest_socket.get_box()
			nearest_socket.consumed_by = selected_box

			refresh_sockets_array()
			selected_box = null



func _on_deck_box_selected(card_res: Resource):
	selected_box = card_res.instantiate()
	add_child(selected_box)
