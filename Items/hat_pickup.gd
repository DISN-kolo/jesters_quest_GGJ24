extends Area2D

var can_pickup = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.is_in_group("player") and can_pickup:
		can_pickup = false
		Stats.hat_donned.emit()
		$AudioStreamPlayer.playing = true
		$AnimatedSprite2D.visible = false


func _on_audio_stream_player_finished():
	self.queue_free()
	pass # Replace with function body.
