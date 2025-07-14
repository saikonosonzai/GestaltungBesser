extends ColorRect


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func start_animation(animation):
	if (animation == "bullet"):
		animation_player.play("Bullet_time")
