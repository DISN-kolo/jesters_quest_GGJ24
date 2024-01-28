extends CharacterBody2D

@export var MAX_HEALTH = 3
@export var speed = 40

@onready var sprite = $Sprite2D

var health = MAX_HEALTH
var death = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var HitEffect = preload("res://Effects/hit_effect.tscn")
var DeathEffect = preload("res://Effects/enemy_death_effect.tscn")

var player = null

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 400)
		
	if player:
		sprite.flip_h = player.position.x - position.x > 0
	sprite.play("idle")
	move_and_slide()

func createHitEffect():
	var hitEffect = HitEffect.instantiate()
	hitEffect.global_position = global_position - Vector2(0, 8)
	get_parent().add_child(hitEffect)
	
func createDeathEffect():
	var deathEffect = DeathEffect.instantiate()
	deathEffect.global_position = global_position - Vector2(0, 16)
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


func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
