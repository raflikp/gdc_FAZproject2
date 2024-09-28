extends TextureButton

@onready var button_click: AudioStreamPlayer2D = $"../../buttonClick"

func _on_pressed() -> void:
	get_node("..").hide_menu()
	button_click.play()
