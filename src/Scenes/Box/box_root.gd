extends Node2D

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL
@onready var box_light = $BoxLight
@onready var inputs = []
@onready var outputs = [$Socket]

var is_powered = true
