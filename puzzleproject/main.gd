extends Node2D

var button
var guide
@onready var button_click: AudioStreamPlayer2D = $buttonClick

func _ready() -> void:
	button = get_node("Button")
	button.visible = false
	guide = get_node("Guide")
	guide.visible = false

func all_nodes_in_zones() -> bool:
	# Get all nodes in the "movable_nodes" group
	var movable_nodes = get_tree().get_nodes_in_group("movable_nodes")

	# Check if each node has been placed in a zone
	for node in movable_nodes:
		if not node.placed:  # If any node is not placed, return false
			return false
	
	# If all nodes are placed, return true
	return true
	
func _process(delta: float) -> void:
	if all_nodes_in_zones():
		print("All nodes are in zones!")
		button.visible = true
	else:
		pass #print ("Some nodes are not yet placed.")

func _on_visible_pressed() -> void:
	button_click.play()
	if guide.visible:
		guide.visible = false
	else:
		guide.visible = true
	
