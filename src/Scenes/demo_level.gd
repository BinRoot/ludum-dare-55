extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var game_over_ui: Control = $GameOverUI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kernel_out_of_sockets():
	game_over_ui.show()


func _on_button_pressed():
	get_tree().reload_current_scene()
