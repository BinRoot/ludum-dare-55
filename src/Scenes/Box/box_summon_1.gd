extends Node2D
signal power_core_clicked

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL
@export var is_relic = true
@export var path_size_factor = 1
@onready var box_light = $BoxLight
@onready var inputs = [$PowerCore, $PowerCore2, $PowerCore3, $PowerCore4]
@onready var outputs = []

var is_powered = false


func _on_power_core_clicked(pc):
	emit_signal("power_core_clicked", pc)
