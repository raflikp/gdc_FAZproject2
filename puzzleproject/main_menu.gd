extends Control

@onready var button_click: AudioStreamPlayer2D = $buttonClick

func _ready() -> void:
	BgmAll.play_music_level()
	
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
	button_click.play()

func _on_exit_pressed() -> void:
	get_tree().quit()
	button_click.play()

func _on_credits_pressed() -> void:
	get_node("Credits")._open_credits()
	button_click.play()
