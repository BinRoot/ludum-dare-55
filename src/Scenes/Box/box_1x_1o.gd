extends Node2D

@export var is_powered = false

@onready var power_core = $PowerCore

var power_cores = [power_core]

var boxConnectionsByPowerCoreName = {}

func _ready():
	pass # Replace with function body.

func turn_on():
	is_powered = true

func turn_off():
	is_powered = false

func _on_power_core_power_consumed(new_box):
	print("new_box ", new_box, " connected to ", self)
	boxConnectionsByPowerCoreName[power_core.name] = new_box

func refresh_power_core_state():
	for pc in power_cores:
		pc.is_powered = boxConnectionsByPowerCoreName[pc.name] == null
			
