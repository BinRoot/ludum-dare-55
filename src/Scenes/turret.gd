extends Node2D

@onready var area2d = $Area2D
@onready var texture = $TextureRect
@onready var random_timer = $RandomTimer
@onready var original_text_position = texture.position
@onready var original_texture_modulate = texture.modulate
@onready var original_texture_scale = texture.scale

var is_used = false
var is_primed = false
var primed_at


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_box():
	return get_parent()

func _physics_process(delta):
	visible = get_box().is_in_play
	area2d.monitoring = get_box().is_in_play
	if not is_used and not is_primed:
		texture.rotation += delta
	if primed_at != null:
		var vec: Vector2 = primed_at - texture.global_position
		texture.position += vec * delta
	elif primed_at == null:
		texture.position = original_text_position
	if is_used:
		texture.visible = false
	if get_box().is_powered:
		scale = original_texture_scale
		modulate = original_texture_modulate
	else:
		scale = original_texture_scale * 0.8
		modulate = Color.CADET_BLUE

func _on_area_2d_area_entered(area):
	if get_box().is_powered and not is_primed and is_target_found(area):
		
		var dir_vec = area.global_position - global_position
		texture.rotation = Vector2.RIGHT.angle_to(dir_vec)
		is_primed = true
		
		random_timer.wait_time = 1 + randf()
		random_timer.start()
		await random_timer.timeout
		
		primed_at = area.global_position
		
		random_timer.wait_time = 1 + randf()
		random_timer.start()
		
		await random_timer.timeout
		if is_target_found(area):
			area.get_parent().queue_free()
			is_used = true
		is_primed = false
		primed_at = null

func is_target_found(area):
	var area_ref = weakref(area)
	if !area_ref.get_ref():
		return false
	return not is_used and area.get_parent().is_in_play and area.get_parent().owned_by != get_box().owned_by and area.get_parent().owned_by != Globals.PlayerID.NEUTRAL
