extends Node2D
signal power_core_clicked

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL
@export var is_relic = false
@export var path_size_factor = 1
@onready var box_light = $BoxLight
@onready var inputs = [$PowerCore]
@onready var outputs = [$Socket]
@onready var animation = $AnimationPlayer


var is_powered = false

func _physics_process(delta):
	if is_in_play:
		animation.play("sway")

func _on_power_core_clicked(pc):
	emit_signal("power_core_clicked", pc)

