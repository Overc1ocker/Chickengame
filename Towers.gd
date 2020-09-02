extends Node2D

var piece
var a

func _ready():
	if piece == 1:
		$"Piece 1".visible = true
		piecer(1, piece)
	elif piece == 2:
		$"Piece 2".visible = true
		piecer(1, piece)

func piecer(delta, piecere):
	if delta < 5:
		piecer(delta + 1, piecere)
		a = str(((piecere * 5) - 5) + delta)
		find_node_by_name(get_tree().get_root(), a).disabled = false

func find_node_by_name(root, name):
	if(root.get_name() == name): return root
	for child in root.get_children():
		if(child.get_name() == name):
			return child
		var found = find_node_by_name(child, name)
		if(found): return found
	return null
