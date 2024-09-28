extends CanvasLayer

@onready var button_click: AudioStreamPlayer2D = $"../buttonClick"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

func _open_credits():
	self.show()

func _on_texture_button_pressed() -> void:
	self.hide()
	button_click.play()
