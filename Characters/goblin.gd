extends CharacterBody2D

@export var MAX_HEALTH = 3

var health = MAX_HEALTH
var death = false

var HitEffect = preload("res://Effects/hit_effect.tscn")
var DeathEffect = preload("res://Effects/enemy_death_effect.tscn")

func createHitEffect():
	var hitEffect = HitEffect.instantiate()
	hitEffect.global_position = global_position
	get_parent().add_child(hitEffect)
	
func createDeathEffect():
	var deathEffect = DeathEffect.instantiate()
	
	deathEffect.global_position = global_position
	get_parent().add_child(deathEffect)

func _on_area_2d_body_entered(body):
	if (body.is_in_group("arrow")):
		body.queue_free()
		health -= 1
		if (health == 0):
			createDeathEffect()
			queue_free()
		else:
			createHitEffect()
