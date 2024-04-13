extends Node

var params = {
	"sec1": {
		"test": 1,
		"isEnabled": true,
		"quickMode": false,
		"person": "bob",
		"test2": [1, 2, 3],
		"isEnabled2": [true, false],
		"quickMode2": false,
		"person2": ["bob", "bob2"],
		"test3": 1,
		"isEnabled3": true,
		"quickMode3": false,
		"person3": "bob",
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
