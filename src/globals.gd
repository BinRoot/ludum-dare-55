extends Node

var params = {
	"misc": {
		"max_path_length": 16,
		"cell_size": 16
	}
}

enum PlayerID { P1, COM1, NEUTRAL }

@onready var settings_ui = preload("res://Scenes/settings_ui.tscn")

var is_violent = false

enum CardTypes { card1a, card1a2, card1b, card1c, card2a, card2a2, card2b, card2c, card3a, card3b, card3c }

var card_types = {
	CardTypes.card1a: {
		'resource_path': preload('res://Scenes/Box/box_1x_1o.tscn'),
		'path_size_factor': 1,
	},
	CardTypes.card1a2: {
		'resource_path': preload('res://Scenes/Box/box_1x_1o.tscn'),
		'path_size_factor': 1,
	},
	CardTypes.card1b: {
		'resource_path': preload('res://Scenes/Box/box_1x_1o.tscn'),
		'path_size_factor': 2,
	},
	CardTypes.card1c: {
		'resource_path': preload('res://Scenes/Box/box_1x_1o.tscn'),
		'path_size_factor': 3,
	},
	CardTypes.card2a: {
		'resource_path': preload('res://Scenes/Box/box_2o.tscn'),
		'path_size_factor': 1,
	},
	CardTypes.card2a2: {
		'resource_path': preload('res://Scenes/Box/box_2o.tscn'),
		'path_size_factor': 1,
	},
	CardTypes.card2b: {
		'resource_path': preload('res://Scenes/Box/box_2o.tscn'),
		'path_size_factor': 2,
	},
	CardTypes.card2c: {
		'resource_path': preload('res://Scenes/Box/box_2o.tscn'),
		'path_size_factor': 3,
	},
	CardTypes.card3a: {
		'resource_path': preload('res://Scenes/Box/box_2x.tscn'),
		'path_size_factor': 1,
	},
	CardTypes.card3b: {
		'resource_path': preload('res://Scenes/Box/box_2x.tscn'),
		'path_size_factor': 2,
	},
	CardTypes.card3c: {
		'resource_path': preload('res://Scenes/Box/box_2x.tscn'),
		'path_size_factor': 3,
	},
}

func _input(event):
	if event.is_action_pressed("ui_settings_toggle"):
		var nodes = get_tree().get_nodes_in_group("settings_ui")
		if nodes.size() > 0:
			for node in nodes:
				node.queue_free()
		else:
			var node = settings_ui.instantiate()
			add_child(node)
