extends CharacterBody2D

@export var MAX_HEALTH = 3

var health = MAX_HEALTH

func _on_body_entered(body):
	if body.is_in_group("arrow"):
		body.queue_free()
		hurt(1)

func hurt(damage):
	health -= damage
	if (health < 1):
		queue_free()
