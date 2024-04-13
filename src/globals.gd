extends Node

var params = {
	"misc": {
		"max_path_length": 10,
	}
}

@onready var settings_ui = preload("res://Scenes/settings_ui.tscn")

func _input(event):
	if event.is_action_pressed("ui_settings_toggle"):
		var nodes = get_tree().get_nodes_in_group("settings_ui")
		if nodes.size() > 0:
			for node in nodes:
				node.queue_free()
		else:
			var node = settings_ui.instantiate()
			add_child(node)
