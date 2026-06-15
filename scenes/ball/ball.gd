extends CharacterBody2D
class_name Ball

@export var speed: float = 400.0
@export var max_bounce_angle: float = 60.0

func _ready() -> void:
	launch()
	
func launch() -> void:
	var dir := 1.0 if randf() > 0.5 else -1.0
	var angle := deg_to_rad(randf_range(-30, 30))
	velocity = Vector2(dir, 0).rotated(angle) * speed
	
func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)
	if collision:
		var collider := collision.get_collider()
		if collider.is_in_group("paddles"):
			_bounce_off_paddle(collider)
		else:
			velocity = velocity.bounce(collision.get_normal())
		velocity = velocity.normalized() * speed
		
func _bounce_off_paddle(paddle: Node2D) -> void:
	var half_height := _paddle_half_height(paddle)
	var offset := clampf((global_position.y - paddle.global_position.y) / half_height, -1.0, 1.0)
	
	var bounce := deg_to_rad(max_bounce_angle) * offset
	var direction := -1.0 if velocity.x > 0 else 1.0
	velocity = Vector2(direction, 0).rotated(bounce) * speed
	
func _paddle_half_height(paddle: Node2D) -> float:
	var shape = paddle.get_node("CollisionShape2D").shape
	if shape is RectangleShape2D:
		return shape.size.y / 2.0
	return 50.0
	
	
	
	
