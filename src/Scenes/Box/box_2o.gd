extends Node2D
signal power_core_clicked

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL
@onready var box_light = $BoxLight
@onready var inputs = [$PowerCore]
@onready var outputs = [$Socket, $Socket2]

var is_powered = false

func _on_power_core_clicked(pc):
	emit_signal("power_core_clicked", pc)
