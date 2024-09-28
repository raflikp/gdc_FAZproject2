extends Button

@onready var finish: AudioStreamPlayer2D = $"../finish"

func _on_pressed() -> void:
	get_node("../gameFinish").game_finish()
	finish.play()
	
	
