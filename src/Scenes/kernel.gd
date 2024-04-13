extends Node2D

@onready var map_ref_rect: ReferenceRect = $MapReferenceRect
@onready var line_for_power_core_distance = $PowerCoreLine2D
var selected_box

var power_cores = []

# Called when the node enters the scene tree for the first time.
func _ready():
	refresh_power_cores_array()

func refresh_power_cores_array():
	power_cores = get_tree().get_nodes_in_group('power')

func get_nearest_power_core():
		var nearest_power_core
		for power_core in power_cores:
			if not nearest_power_core:
				nearest_power_core = power_core
			else:
				if power_core.global_position.distance_to(selected_box.global_position) < nearest_power_core.global_position.distance_to(selected_box.global_position):
					nearest_power_core = power_core
		return nearest_power_core

func _process(_delta):
	if selected_box:
		selected_box.position = get_global_mouse_position()
		var nearest_power_core = get_nearest_power_core()
		line_for_power_core_distance.points = [selected_box.global_position, nearest_power_core.global_position]

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and selected_box != null:
			selected_box = null
			var nearest_power_core = get_nearest_power_core()
			# create a new line2d object from the nearest power core to the mouse position
			var line2d = Line2D.new()
			line2d.points = [nearest_power_core.global_position, get_global_mouse_position()]
			add_child(line2d)


func _on_deck_box_selected(card_res: Resource):
	print('in kernel, card selected', card_res)
	selected_box = card_res.instantiate()
	add_child(selected_box)
