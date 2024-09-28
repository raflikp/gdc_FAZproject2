extends Node2D

var selected = false
var rest_point
var rest_nodes = []
var rest_distance_threshold = 75  # Distance threshold to consider resting
var current_zone = null  # Store the current zone the node is resting in
var placed = false  # Track if this node has been placed in a zone
@onready var wood_audio_effect: AudioStreamPlayer2D = $"../wood_audioEffect"
@onready var rotate_effect: AudioStreamPlayer2D = $"../rotateEffect"

func _ready() -> void:
	add_to_group("movable_nodes")
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()
	current_zone = rest_nodes[0]

func _input(event: InputEvent) -> void:
	# Ensure that only the node being clicked on is selected or moved
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Toggle the selected state on left-click
			if not selected and is_mouse_over():
				selected = true
				wood_audio_effect.play()
			elif selected:
				selected = false
				place_node()

		elif event.button_index == MOUSE_BUTTON_RIGHT and event.pressed and selected:
			# Rotate by 15 degrees on right-click, but only if the node is selected
			rotation += deg_to_rad(45)
			rotate_effect.play()

func _physics_process(delta: float) -> void:
	if selected:
		# Only move this node when it's selected
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		# Handle placing logic if not selected
		var is_near_zone = false
		for child in rest_nodes:
			if not child.occupied and global_position.distance_to(child.global_position) < rest_distance_threshold:
				is_near_zone = true
				break

		if is_near_zone and current_zone:
			current_zone.deselect()

			global_position = lerp(global_position, rest_point, 10 * delta)
			#rotation = lerp_angle(rotation, 0, 25 * delta)

func place_node() -> void:
	# Place the node in the closest valid rest zone
	var shortest_dist = rest_distance_threshold
	var closest_zone = null
	for child in rest_nodes:
		var distance = global_position.distance_to(child.global_position)
		if not child.occupied and distance < shortest_dist:
			closest_zone = child
			rest_point = child.global_position
			shortest_dist = distance

	# Place the node in the closest zone if found
	if closest_zone:
		if current_zone:
			current_zone.deselect()
		closest_zone.select()
		current_zone = closest_zone
		placed = true
		wood_audio_effect.play()

# This function helps detect if the mouse is over the node
func is_mouse_over() -> bool:
	var mouse_pos = get_global_mouse_position()
	return global_position.distance_to(mouse_pos) <= 32  # Adjust the radius if needed
