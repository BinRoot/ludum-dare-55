extends Node2D

@onready var camera: Camera2D = $Camera2D
@onready var game_over_ui: Control = $GameOverUI
@onready var game_over_label: Label = $GameOverUI/Label
@onready var hint_ui: Control = $HintUI
@onready var hint_label: Label = $HintUI/Label
@onready var hint_timer: Timer = $HintTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kernel_out_of_sockets():
	hint_timer.start()
	hint_ui.show()
	hint_label.text = "Hint: delete a unit to make room for an open slot."

func _on_kernel_com_summons():
	game_over_ui.show()
	game_over_label.text = "Game Over - They Summoned First!"

func _on_kernel_player_summons():
	game_over_ui.show()
	game_over_label.text = "Victory! We Summoned First!"


func _on_button_pressed():
	get_tree().reload_current_scene()




func _on_hint_timer_timeout():
	hint_ui.hide()
