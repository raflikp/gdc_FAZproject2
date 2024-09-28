extends CanvasLayer

@onready var button_click: AudioStreamPlayer2D = $"../buttonClick"

func _ready() -> void:
	self.hide()

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	button_click.play()
	
func game_finish():
	self.show()

func _on_keluar_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	button_click.play()
