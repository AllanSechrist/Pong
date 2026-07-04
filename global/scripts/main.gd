extends Node2D

@export_file("*.tscn") var game_over_scene: String
@export var win_score: int = 11

@onready var ball: Ball = $Ball
@onready var player_1_score_label: Label = $UI/MarginContainer/HBoxContainer/Player1ScoreLabel
@onready var player_2_score_label: Label = $UI/MarginContainer/HBoxContainer/Player2ScoreLabel
@onready var left_goal: Area2D = $Goals/LeftGoal
@onready var right_goal: Area2D = $Goals/RightGoal
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound

var player_1_score: int = 0
var player_2_score: int = 0

func _ready() -> void:
	left_goal.body_entered.connect(_on_goal_scored.bind(2, -1.0))
	right_goal.body_entered.connect(_on_goal_scored.bind(1, 1.0))
	_update_labels()
	ball.reset_and_serve()
	
func _on_goal_scored(body: Node, scorer: int, serve_dir: float) -> void:
	if body != ball:
		return # ignore anything that isn't a ball.
		
	if scorer == 1:
		player_1_score += 1
	else:
		player_2_score += 1
	_update_labels()
	
	if player_1_score >= win_score or player_2_score >= win_score:
		_end_game(scorer)
	else:
		score_sound.play()
		ball.reset_and_serve(serve_dir)
		
	
		
func _update_labels() -> void:
	player_1_score_label.text = str(player_1_score)
	player_2_score_label.text = str(player_2_score)
	
func _end_game(winner: int) -> void:
	ball.velocity = Vector2.ZERO
	GameOver.winner = winner
	get_tree().change_scene_to_file(game_over_scene)
