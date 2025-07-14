extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var color_rect: ColorRect = $"../CanvasLayer/ColorRect"

@export var bullet_time_duration := 3.0
@export var bullet_time_cooldown := 5.0
var can_use_bullet_time := true

@export var time_stop_duration := 2.0
var can_use_time_stop := true

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
	
		# Fähigkeiten aktivieren
	if Input.is_action_just_pressed("bullet_time"):
		activate_bullet_time()

func activate_bullet_time():
	if not GameState.unlocked_skills["bullet_time"]:
		return
	if GameState.is_bullet_time or not can_use_bullet_time:
		return
	
	color_rect.start_animation("bullet")
	can_use_bullet_time = false
	GameState.is_bullet_time = true
	Engine.time_scale = 0.3
	print("Bullet Time aktiviert")

	await get_tree().create_timer(bullet_time_duration, true).timeout
	Engine.time_scale = 1.0
	GameState.is_bullet_time = false
	print("Bullet Time vorbei")

	await get_tree().create_timer(bullet_time_cooldown, true).timeout
	can_use_bullet_time = true
	print("Bullet Time bereit")


func _on_area_2d_body_entered(body: Node2D) -> void:
	camera_2d.limit_left = 784


func _on_area_2d_body_exited(body: Node2D) -> void:
	camera_2d.limit_left = -205


func _on_faehigkeit_body_entered(body: Node2D) -> void:
	pass #hier collision mit fähigkeit in level 01
