extends Node

var draggable_nodes = []  # Array to hold all draggable nodes

func _ready() -> void:
	# Get all nodes that should be draggable
	draggable_nodes = get_tree().get_nodes_in_group("zone")

func check_all_nodes_placed() -> bool:
	for node in draggable_nodes:
		if not node.placed:  # Check if any node is not placed
			return false
	return true
	
func finish_game() -> void:
	if check_all_nodes_placed() == true:
		get_tree().quit()
