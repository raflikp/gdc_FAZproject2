extends Node2D

var button_visible = false  # To track if the button is visible

# The area of the button, you can use a custom area or derive it from the sprite's size
var button_size = Vector2(100, 50)  # Example size, adjust based on your actual button size

func _ready() -> void:
	hide()  # Initially hide the button

func _input(event: InputEvent) -> void:
	if button_visible and event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var button_rect = Rect2(global_position - button_size * 0.5, button_size)

		# Check if the mouse is within the button's area
		if button_rect.has_point(mouse_pos):
			_on_button_pressed()

# Function to show the button when needed
func show_button() -> void:
	show()  # Show the Node2D
	button_visible = true

# Function to hide the button when needed
func hide_button() -> void:
	hide()  # Hide the Node2D
	button_visible = false
