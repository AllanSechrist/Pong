extends Control
class_name StartMenu
static var winner: int = 0

@export_file("*.tscn") var game_scene: String
@export_file("*.tscn") var menu_scene: String
@onready var game_title: Label = $VBoxContainer/GameTitle
@onready var start_button: Button = $VBoxContainer/StartButton
@onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready() -> void:
	start_button.pressed.connect(_on_play)
	quit_button.pressed.connect(_on_quit)

func _on_play() -> void:
	get_tree().change_scene_to_file(game_scene)
	
func _on_quit() -> void:
	get_tree().quit()
	
