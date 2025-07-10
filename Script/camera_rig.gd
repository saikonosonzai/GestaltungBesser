extends CharacterBody2D

@export var target_path: NodePath = "../Player"
@export var follow_speed := 0    # Je größer, desto straffer folgt das Rig

var _target: Node2D

func _ready():
	_target = get_node_or_null(target_path)

func _physics_process(delta:float) -> void:
	if not _target:
		return


	move_and_slide()
