extends Node2D

@onready var power_core1 = $PowerCore
@onready var socket1 = $Socket
@onready var socket2 = $Socket2
@onready var box_light = $BoxLight
@onready var inputs = [power_core1]
@onready var outputs = [socket1, socket2]

# derived by the inputs
var is_powered = false

func _physics_process(_delta):
	# all inputs must be consumed by a powered box for this box to be powered
	is_powered = true
	for pc in inputs:
		if not pc.is_powered():
			is_powered = false
			break
	
	if is_powered:
		box_light.turn_on()
	else:
		box_light.turn_off()
