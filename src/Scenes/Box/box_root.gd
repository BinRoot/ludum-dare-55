extends Node2D

@onready var socket = $Socket

@onready var inputs = []
@onready var outputs = [socket]

# derived by the inputs
var is_powered = true

@export var is_in_play = false

func _physics_process(_delta):
	# all inputs must be consumed by a powered box for this box to be powered
	is_powered = true
	for input in inputs:
		var input_source_box = input.consumed_by
		if input_source_box == null:
			is_powered = false
			break
		elif not input_source_box.is_powered:
			is_powered = false
			break
