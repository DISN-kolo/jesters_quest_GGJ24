extends CharacterBody2D

@export var MAX_HEALTH = 3

@onready var hurtBox = $HurtBox

var health = MAX_HEALTH
var death = false

func _on_hurt_box_body_entered(body):
	if (body.is_in_group("player")):
		#body.queue_free()
		health -= 1
		hurtBox.createHitEffect()
		if (health > 0):
			hurtBox.startInvinvibility(1)
		else:
			death = true

func _on_timer_timeout():
	if (death):
		queue_free()
