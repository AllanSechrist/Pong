extends CharacterBody2D

@export var speed: float = 350.0  # slightly slower than the player = beatable
@export var ball_path: NodePath   

var _half_height: float
var _ball: Node2D

func _ready() -> void:
	var shape = $CollisionShape2D.shape
	_half_height = shape.size.y / 2.0 if shape is RectangleShape2D else 50.0
	_ball = get_node(ball_path)

func _physics_process(_delta: float) -> void:
	var diff := _ball.global_position.y - global_position.y
	var direction := signf(diff) if absf(diff) > 10.0 else 0.0 
	velocity = Vector2(0, direction * speed)

	move_and_slide()

	var screen_height := get_viewport_rect().size.y
	global_position.y = clampf(global_position.y, _half_height, screen_height - _half_height)
