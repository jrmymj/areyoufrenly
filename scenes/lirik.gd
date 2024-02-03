extends CharacterBody2D

@export var speed = 600
var screen_size
var last_direction = Vector2.RIGHT

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		last_direction = Vector2.RIGHT
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		last_direction = Vector2.LEFT
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "walking"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "idling"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = last_direction == Vector2.LEFT
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
