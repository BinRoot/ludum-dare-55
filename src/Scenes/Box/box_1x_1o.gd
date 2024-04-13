extends Node2D
signal power_core_clicked

@onready var power_core1 = $PowerCore
@onready var socket1 = $Socket
@onready var box_light = $BoxLight
@onready var inputs = [power_core1]
@onready var outputs = [socket1]

# derived by the inputs
var is_powered = false

@export var is_in_play = false

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


func _on_power_core_clicked(pc):
	emit_signal("power_core_clicked", pc)
