extends CanvasLayer

@onready var button_click: AudioStreamPlayer2D = $"../buttonClick"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

func help_menu():
	self.show()
	
func hide_menu():
	self.hide()
	button_click.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
