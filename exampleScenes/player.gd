extends CharacterBody2D

@export var speed := 200.0
@export var jump_force := 400.0
@export var gravity := 900.0

@onready var sprite: Sprite2D = $Sprite
@onready var jump_handler: Node = $CoyoteJump

func _physics_process(delta):
	# Horizontal movement
	var direction := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed
	
	# Flip sprite based on movement direction (no flip = right)
	if direction != 0:
		sprite.flip_h = direction < 0
	
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0.0

	jump_handler.set_on_floor(is_on_floor())

	# Jump using coyote time + buffer
	if jump_handler.consume_jump():
		velocity.y = -jump_force

	move_and_slide()
