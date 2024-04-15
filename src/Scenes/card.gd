extends Node2D
signal card_hovered
signal card_selected
signal card_unselected

@export var card_type: Globals.CardTypes
@onready var subtype1 = $Subtype1
@onready var subtype2 = $Subtype2
@onready var subtype3 = $Subtype3
@onready var audio = $AudioStreamPlayer
@onready var audio2 = $AudioStreamPlayer2

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
		audio2.play()

func _physics_process(delta):
	if is_selected:
		modulate = Color.DARK_KHAKI
		modulate.a = 0.1
	else:
		modulate = Color.WHITE
		modulate.a = 1
	subtype1.hide()
	subtype2.hide()
	subtype3.hide()
	if Globals.card_types[card_type]["path_size_factor"] == 1:
		subtype1.show()
	if Globals.card_types[card_type]["path_size_factor"] == 2:
		subtype2.show()
	if Globals.card_types[card_type]["path_size_factor"] == 3:
		subtype3.show()
		

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed() and not is_selected:
		emit_signal("card_selected", self)
		audio.play()
		is_selected = true
	elif event is InputEventMouseButton and event.is_pressed() and is_selected:
		emit_signal("card_unselected")
		is_selected = false
