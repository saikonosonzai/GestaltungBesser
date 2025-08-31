extends Area2D
@onready var how_to_use: Label = $"../howToUse"



func _on_body_entered(body: Node2D) -> void:
	how_to_use.visible = true
	how_to_use.text = "Press Shift"
	GameState.unlocked_skills["bullet_time"] = true
