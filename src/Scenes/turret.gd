extends Node2D

@onready var area2d = $Area2D
@onready var texture = $TextureRect
@onready var random_timer = $RandomTimer
var is_used = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_box():
	return get_parent()

func _physics_process(delta):
	visible = get_box().is_in_play
	area2d.monitoring = get_box().is_in_play
	if not is_used:
		texture.rotation += delta

func _on_area_2d_area_entered(area):
	if is_target_found(area):
		random_timer.wait_time = randf() / 4
		random_timer.start()
		await random_timer.timeout
		if is_target_found(area):
			var dir_vec = area.global_position - global_position
			texture.rotation = Vector2.RIGHT.angle_to(dir_vec)
			area.get_parent().queue_free()
			is_used = true

func is_target_found(area):
	var area_ref = weakref(area)
	if !area_ref.get_ref():
		return false
	return not is_used and area.get_parent().is_in_play and area.get_parent().owned_by != get_box().owned_by and area.get_parent().owned_by != Globals.PlayerID.NEUTRAL
