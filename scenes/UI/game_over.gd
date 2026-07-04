extends Control
class_name GameOver

@export_file("*.tscn") var game_scene: String
@export_file("*.tscn") var menu_scene: String

@onready var winner_label: Label = $VBoxContainer/WinnerLabel
@onready var start_button: Button = $VBoxContainer/StartButton
@onready var main_menu_button: Button = $VBoxContainer/MainMenuButton
@onready var quit_button: Button = $VBoxContainer/QuitButton



static var winner: int = 0

func _ready() -> void:
	winner_label.text = "Player %d Wins!" % winner
	start_button.pressed.connect(_on_play_again)
	main_menu_button.pressed.connect(_on_menu)
	quit_button.pressed.connect(_on_quit)

func _on_play_again() -> void:
	get_tree().change_scene_to_file(game_scene)
	
func _on_menu() -> void:
	get_tree().change_scene_to_file(menu_scene)
	
func _on_quit() -> void:
	get_tree().quit()
