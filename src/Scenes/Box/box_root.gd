extends Node2D

@export var is_in_play = false
@export var owned_by: Globals.PlayerID = Globals.PlayerID.NEUTRAL
@export var is_relic = true
@export var path_size_factor = 1
@onready var box_light = $BoxLight
@onready var inputs = []
@onready var outputs = [$Socket]

var is_powered = true
