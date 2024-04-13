extends Node2D
signal box_selected

@onready var card_res = preload("res://Scenes/card.tscn")
@onready var ref_rect = $ReferenceRect
@onready var card_hover_tween: Tween
@onready var card_holder: Node = $CardHolder

func _ready():
	for i in range(0, 5):
		var card: Node = card_res.instantiate()
		card_holder.add_child(card)
		card.connect("card_hovered", _on_card_hovered)
		card.connect("card_selected", _on_card_selected)
	reposition_cards()

func reposition_cards():
	var rect: Rect2 = ref_rect.get_rect()
	var rect_width = rect.size[0]
	for i in card_holder.get_child_count():
		var card = card_holder.get_child(i)
		card.position.x = (-rect_width / 2) + (rect_width / (card_holder.get_child_count() + 1))*(i + 1)
		card.position.y = 0

func _on_card_hovered(card):
	if card_hover_tween:
		card_hover_tween.kill()
		reposition_cards()
	card_hover_tween = get_tree().create_tween()
	var original_card_position = card.position
	card_hover_tween.tween_property(card, "position", original_card_position + Vector2.UP * 10, 0.1)
	card_hover_tween.tween_property(card, "position", original_card_position, 0.1)

func _on_card_selected(card):
	emit_signal("box_selected", card.get_card_res())
