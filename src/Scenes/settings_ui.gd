extends Control

@onready var tree = $Tree

func _ready():
	var root = tree.create_item()
	for key in Globals.params.keys():
		var child = tree.create_item(root)
		child.set_text(0, key)
		child.set_text(1, 'Value')
		for subkey in Globals.params[key].keys():
			var subchild = tree.create_item(child)
			subchild.set_text(0, subkey)
			subchild.set_editable(1, true)			
			var value = Globals.params[key][subkey]
			if typeof(value) == TYPE_STRING:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_STRING)
				subchild.set_text(1, value)
			elif typeof(value) == TYPE_BOOL:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_CHECK)
				subchild.set_checked(1, value)
			else:
				subchild.set_cell_mode(1, TreeItem.CELL_MODE_STRING)
				subchild.set_text(1, str(value))


func _on_tree_item_edited():
	var root: TreeItem = tree.get_root()
	for i in root.get_child_count():
		var sec = root.get_child(i)
		var secName = sec.get_text(0)
		for j in sec.get_child_count():
			var secProp: TreeItem = sec.get_child(j)
			var propName = secProp.get_text(0)
			var rawPropVal = secProp.get_text(1)
			var propVal = null
			var propCellMode = secProp.get_cell_mode(1)
			if propCellMode == TreeItem.CELL_MODE_CHECK:
				propVal = secProp.is_checked(1)
			elif propCellMode == TreeItem.CELL_MODE_STRING and typeof(Globals.params[secName][propName]) != TYPE_STRING:
				var json = JSON.new()
				var error = json.parse(rawPropVal)
				propVal = json.data
			else:
				propVal = rawPropVal
			Globals.params[secName][propName] = propVal


func _on_save_button_pressed():
	queue_free()


