extends Node2D
signal clicked

@onready var texture: TextureRect = $TextureRect
@onready var highlighted_ui: TextureRect = $HighlightedUI
@onready var original_modulate = texture.modulate

var consumed_by

var is_selected = false

func _ready():
	pass

func is_powered():
	return consumed_by != null and consumed_by.is_powered

func get_box():
	return get_parent()

func _physics_process(delta):
	if consumed_by == null:
		texture.modulate = original_modulate
		highlighted_ui.visible = get_box().is_in_play
	else:
		texture.modulate = Color.GREEN_YELLOW
		highlighted_ui.visible = false

	
	if highlighted_ui.visible:
		var rotation_speed = 5
		if is_selected:
			rotation_speed = 30
		highlighted_ui.rotation_degrees += delta * rotation_speed


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and highlighted_ui.visible:
		is_selected = true
		emit_signal("clicked", self)
