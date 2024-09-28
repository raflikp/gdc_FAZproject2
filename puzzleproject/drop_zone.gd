extends Marker2D

var occupied = false  # Flag to indicate if the zone is occupied

#func _draw() -> void:
#	draw_circle(Vector2.ZERO, 10, Color.BLANCHED_ALMOND)

func select() -> void:
	# Deselect all other zones and mark this zone as occupied
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	#modulate = Color.WEB_MAROON
	occupied = true
	
func deselect() -> void:
	# Unmark this zone as occupied
	modulate = Color.WHITE
	occupied = false
