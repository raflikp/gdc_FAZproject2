extends Node2D

var selected = false
var rest_points = []  # List of points where the node rests
var rest_nodes = []  # List of all zones (Marker2D)
var rest_distance_threshold = 75  # Distance threshold to consider resting
var current_zones = []  # Store the current zones the node is resting in

func _ready() -> void:
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_points.append(rest_nodes[0].global_position)
	rest_nodes[0].select()
	current_zones.append(rest_nodes[0])

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true
		
func _physics_process(delta: float) -> void:
	if selected:
		# Move towards the mouse when selected
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
		look_at(get_global_mouse_position())
	else:
		# Find zones within the rest distance threshold
		var zones_to_occupy = []
		for child in rest_nodes:
			# Check if the zone is not occupied and is within the threshold
			if not child.occupied and global_position.distance_to(child.global_position) < rest_distance_threshold:
				zones_to_occupy.append(child)
		
		# If there are valid zones to occupy, update the resting zones
		if zones_to_occupy.size() > 0:
			occupy_zones(zones_to_occupy)
			rotation = lerp_angle(rotation, 0, 25 * delta)

func occupy_zones(zones: Array) -> void:
	# Deselect previously occupied zones
	for zone in current_zones:
		zone.deselect()

	# Select up to two closest zones
	current_zones.clear()
	for i in range(min(zones.size(), 2)):  # Occupy only up to 2 zones
		zones[i].select()
		current_zones.append(zones[i])

	# Calculate the average rest point between the two zones
	rest_points.clear()
	for zone in current_zones:
		rest_points.append(zone.global_position)

	# Move the node towards the average point of the occupied zones
	var average_point = Vector2.ZERO
	for point in rest_points:
		average_point += point
	average_point /= rest_points.size()
	global_position = lerp(global_position, average_point, 10 * 0.016)  # Use a fixed timestep for smoothing

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var closest_zones = []
			# Find the two closest unoccupied zones
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if not child.occupied and distance < rest_distance_threshold:
					closest_zones.append(child)

			# Sort zones by proximity to the node
			closest_zones.sort_custom(Callable(self, "_compare_distance"))

			# Occupy the two closest zones
			if closest_zones.size() > 0:
				occupy_zones(closest_zones)

# Helper function to sort zones based on distance
func _compare_distance(a, b) -> int:
	var dist_a = global_position.distance_to(a.global_position)
	var dist_b = global_position.distance_to(b.global_position)
	return int(dist_a - dist_b)
