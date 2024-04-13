extends Node2D
signal power_core_clicked

@onready var power_core1 = $PowerCore
@onready var power_core2 = $PowerCore2
@onready var power_core3 = $PowerCore3
@onready var power_core4 = $PowerCore4
@onready var box_light = $BoxLight
@onready var inputs = [power_core1, power_core2, power_core3, power_core4]
@onready var outputs = []

# derived by the inputs
var is_powered = false

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL

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
