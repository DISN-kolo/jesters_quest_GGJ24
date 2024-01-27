extends CharacterBody2D

@export var MAX_HEALTH = 3
@export var speed = 40

@onready var sprite = $Sprite2D

var health = MAX_HEALTH
var death = false
@export var SHOOT_CD = 3
var shoot_cd = SHOOT_CD

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var HitEffect = preload("res://Effects/hit_effect.tscn")
var DeathEffect = preload("res://Effects/enemy_death_effect.tscn")

var player = null
var enemy_arrow = preload("res://Projectile/goblinarrow.tscn")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, 400)
		
	if player:
		sprite.play("shooting")
		if shoot_cd <= 0:
			shoot_cd = SHOOT_CD
			var target = player.global_position
			var start = self.global_position
			var enemy_arrow_instance = enemy_arrow.instantiate()
			enemy_arrow_instance.global_position = start - Vector2(0, 10)
			enemy_arrow_instance.rotation = (target - start).angle()
			enemy_arrow_instance.vel = (target - start)
			owner.add_child(enemy_arrow_instance)
		else:
			shoot_cd -= delta
		#sprite.flip_h = player.position.x - position.x > 0
	else:
		sprite.play("standing")
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
		
		
#func shoot():
	#var arrowsprite = arrows[random.randi_range(0, 3)]
	#var target = get_global_mouse_position()
	#var start = self.global_position - Vector2(_facing_direction*10, 0) - Vector2(10, 0) # I HAVE NO IDEA WHY DID IT OFFSET TO THE RIGHT
	#t(start)
	#var arrow = arrow_scene.instantiate()
	#arrow.sprite = arrowsprite
	#arrow.global_position = start
	##arrow.rotation = (target - start).angle() + PI/2
	#arrow.vel = (target - start)
	##arrow.speed = 2000
	##arrow.target = target
	#owner.add_child(arrow)

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
