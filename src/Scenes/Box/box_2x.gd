extends Node2D
signal power_core_clicked

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL
@export var is_relic = false
@onready var inputs = [$PowerCore]
@onready var outputs = []

var is_powered = true

func _on_power_core_clicked(pc):
	emit_signal("power_core_clicked", pc)
