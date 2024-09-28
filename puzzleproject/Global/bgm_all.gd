extends AudioStreamPlayer2D

const level_music = preload("res://puzzle_2beta2.mp3")

# Called when the node enters the scene tree for the first time.
func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	
	stream = music 
	volume_db = volume
	play()

func play_music_level():
	_play_music(level_music)
	
