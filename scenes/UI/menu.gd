extends Control


func _ready() -> void:
	Music.play_music()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sandbox.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
