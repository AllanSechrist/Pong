extends AudioStreamPlayer2D

func play_music() -> void:
	if playing:
		return
	play()
	
func fade_out(duration: float = 1.0) -> void:
	var tween := create_tween()
	tween.tween_property(self, "volume_db", -40.0, duration)
	await tween.finished
	stop()
	volume_db = 0.0
