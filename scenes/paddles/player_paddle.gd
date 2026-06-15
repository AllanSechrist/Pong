extends CharacterBody2D

@export var speed: float = 500.0 
@export var up_action: String = "move_up"      
@export var down_action: String = "move_down"

var _half_height: float

func _ready() -> void:
	
	var shape = $CollisionShape2D.shape
	_half_height = shape.size.y / 2.0 if shape is RectangleShape2D else 50.0

func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis(up_action, down_action)
	velocity = Vector2(0, direction * speed)

	move_and_slide()

	var screen_height := get_viewport_rect().size.y
	global_position.y = clampf(global_position.y, _half_height, screen_height - _half_height)
