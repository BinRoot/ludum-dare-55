extends Node2D
signal card_hovered
signal card_selected


@export var card_type: Globals.CardTypes

func _ready():
	var card_res: Resource = get_card_res()
	var card_instance: Node = card_res.instantiate()
	add_child(card_instance)

func get_card_res() -> Resource:
	return Globals.card_types[card_type]['resource_path']

func _on_area_2d_mouse_entered():
	emit_signal("card_hovered", self)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("card_selected", self)
