extends CharacterBody2D
class_name Ball

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var starting_speed: float = 400.0
@export var max_speed: float = 1600.0
@export var speed_multiplier: float = 1.05
@export var max_bounce_angle: float = 60.0
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var _start_position: Vector2
var current_speed := clampf(starting_speed, starting_speed, max_speed)

func _ready() -> void:
	_start_position = global_position
	current_speed = starting_speed
	visible_on_screen_notifier_2d.screen_exited.connect(reset_and_serve) #DEBUG

func launch(dir: float = 0.0) -> void:
	if dir == 0.0:
		print("launch!")
		dir = 1.0 if randf() > 0.5 else -1.0
	var angle := deg_to_rad(randf_range(-30, 30))
	velocity = Vector2(dir, 0).rotated(angle) * current_speed
	
func reset_and_serve(dir: float = 0.0) -> void:
	velocity = Vector2.ZERO
	global_position = _start_position
	current_speed = starting_speed
	await get_tree().create_timer(1.0).timeout
	launch(dir)
	
func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision:
		var collider := collision.get_collider()
		print(collider.name)
		if collider is Paddle:
			audio_stream_player_2d.play()
			_bounce_off_paddle(collider)
		else:
			velocity = velocity.bounce(collision.get_normal())
			print(current_speed)
		current_speed *= speed_multiplier
		print(current_speed)
		velocity = velocity.normalized() * current_speed
		
func _bounce_off_paddle(paddle: Node2D) -> void:
	var half_height := _paddle_half_height(paddle)
	var offset := clampf((global_position.y - paddle.global_position.y) / half_height, -1.0, 1.0)
	
	var bounce := deg_to_rad(max_bounce_angle) * offset
	var direction := -1.0 if velocity.x > 0 else 1.0
	velocity = Vector2(direction, 0).rotated(bounce) * current_speed
	
func _paddle_half_height(paddle: Node2D) -> float:
	var shape = paddle.get_node("CollisionShape2D").shape
	if shape is RectangleShape2D:
		return shape.size.y / 2.0
	return 50.0

	

	
	
	
	
