extends Node2D

enum CardTypes { card1 }

var card_types = {
	CardTypes.card1: {
		'resource_path': preload('res://Scenes/Box/box_1x_1o.tscn')
	}
}

@export var card_type: CardTypes

func _ready():
	var card_scene = card_types[card_type]['resource_path'].instance()
	add_child(card_scene)


func _process(delta):
	pass
