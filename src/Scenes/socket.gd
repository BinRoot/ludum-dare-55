extends Node2D

var consumed_by
@onready var texture = $TextureRect
@onready var original_modulate = texture.modulate 

var line2d: Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_box():
	return get_parent()

func _notification(what):
	if what == NOTIFICATION_PREDELETE and line2d != null:
		prints(name, ' freeing')
		var wf = weakref(line2d)
		if wf.get_ref():
			line2d.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if consumed_by == null:
		texture.modulate = original_modulate
	else:
		texture.modulate = Color.YELLOW
		
