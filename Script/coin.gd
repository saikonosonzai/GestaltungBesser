extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	audio_stream_player_2d.playing = true
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()
