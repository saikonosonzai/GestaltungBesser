extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D

func _physics_process(delta: float) -> void:
	# Schwerkraft anwenden
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Springen
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Bewegungseingabe verarbeiten
	var direction := Input.get_axis("Move_Left", "Move_Right")
	if direction != 0:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animation je nach Zustand setzen
	if is_on_floor():
		if abs(velocity.x) > 1:
			if animated_sprite_2d.animation != "Run":
				animated_sprite_2d.play("Run")
		else:
			if animated_sprite_2d.animation != "Idle":
				animated_sprite_2d.play("Idle")

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	camera_2d.limit_left = 784


func _on_area_2d_body_exited(body: Node2D) -> void:
	camera_2d.limit_left = -205


func _on_faehigkeit_body_entered(body: Node2D) -> void:
	pass #hier collision mit fähigkeit in level 01
