extends Node2D
signal card_hovered
signal card_selected
signal card_unselected

@export var card_type: Globals.CardTypes
var is_selected = false

func _ready():
	var card_res: Resource = get_card_res()
	var card_instance: Node = card_res.instantiate()
	add_child(card_instance)

func get_card_res() -> Resource:
	return Globals.card_types[card_type]['resource_path']

func _on_area_2d_mouse_entered():
	if not is_selected:
		emit_signal("card_hovered", self)

func _physics_process(delta):
	if is_selected:
		modulate = Color.DARK_KHAKI
		modulate.a = 0.1
	else:
		modulate = Color.WHITE
		modulate.a = 1
		

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and not is_selected:
		emit_signal("card_selected", self)
		is_selected = true
	elif event is InputEventMouseButton and event.is_pressed() and is_selected:
		emit_signal("card_unselected")
		is_selected = false
