extends Area2D

var HitEffect = preload("res://Effects/hit_effect.tscn")

signal invincibilityStart
signal invincibilityEnd

@onready var timer = $Timer

var invincible: bool = false :
	set(value):
		invincible = value
		if(invincible):
			emit_signal("invincibilityStart")
		else:
			emit_signal("invincibilityEnd")

func createHitEffect():
	var hitEffect = HitEffect.instantiate()
	get_parent().add_child(hitEffect)
	hitEffect.global_position = global_position

func startInvinvibility(duration):
	self.invincible = true
	timer.start(duration)

func _on_timer_timeout():
	self.invincible = false

func _on_invincibility_start():
	set_deferred("monitoring", false)

func _on_invincibility_end():
	monitoring = true
