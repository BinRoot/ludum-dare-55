extends Node

var params = {
	"misc": {
		"max_path_length": 10,
	}
}

enum PlayerID { P1, COM1, NEUTRAL }

@onready var settings_ui = preload("res://Scenes/settings_ui.tscn")

enum CardTypes { card1, card2 }

var card_types = {
	CardTypes.card1: {
		'resource_path': preload('res://Scenes/Box/box_1x_1o.tscn')
	},
	CardTypes.card2: {
		'resource_path': preload('res://Scenes/Box/box_2o.tscn')
	}
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
