extends CanvasLayer

var showed = false
@onready var button_click: AudioStreamPlayer2D = $"../buttonClick"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

func pause_menu():
	if showed == false:
		self.show()
		showed = true
	else:
		self.hide()
		showed = false
	
func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	button_click.play()

func _on_bantuan_pressed() -> void:
	get_node("../help").help_menu()
	button_click.play()

func _on_keluar_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
	button_click.play()
