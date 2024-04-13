extends Node2D

@onready var texture = $TextureRect
@onready var original_modulate = texture.modulate


func turn_on():
	texture.modulate = original_modulate 
	
func turn_off():
	texture.modulate = Color.WHITE
