extends Node2D
signal consumed

var consumed_by

func _ready():
	pass

func is_powered():
	return consumed_by != null and consumed_by.is_powered

func get_box():
	return get_parent()

func _physics_process(_delta):
	visible = consumed_by != null
