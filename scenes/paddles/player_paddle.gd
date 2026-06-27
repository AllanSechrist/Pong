extends CharacterBody2D
class_name Paddle

@export var speed: float = 500.0
@export var player_1: bool

var _half_height: float
var _up_action: String
var _down_action: String

func _ready() -> void:
	var shape = $CollisionShape2D.shape
	_half_height = shape.size.y / 2.0 if shape is RectangleShape2D else 50.0
	# Resolve which input actions this paddle listens to, once.
	_up_action = "player_1_up" if player_1 else "player_2_up"
	_down_action = "player_1_down" if player_1 else "player_2_down"

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis(_up_action, _down_action)
	velocity = Vector2(0, direction * speed)
	move_and_slide()
	var screen_height := get_viewport_rect().size.y
	global_position.y = clampf(global_position.y, _half_height, screen_height - _half_height)
