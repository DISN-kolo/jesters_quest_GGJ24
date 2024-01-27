extends CharacterBody2D

@export var MAX_HEALTH = 3

@onready var hurtBox = $HurtBox

var health = MAX_HEALTH
var death = false

var DeathEffect = preload("res://Effects/enemy_death_effect.tscn")

func createDeathEffect():
	var deathEffect = DeathEffect.instantiate()
	
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position

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
		createDeathEffect()
		queue_free()
