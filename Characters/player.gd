extends CharacterBody2D


@export var SPEED = 180.0
@export var JUMP_VELOCITY = -400.0

@export var down_vel_max = 400.0

@export var SHOOT_CD = 0.1
var shoot_cd = SHOOT_CD

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var _facing_direction := -1
var _was_moving := false

var HitEffect = preload("res://Effects/hit_effect.tscn")
var DeathEffect = preload("res://Effects/enemy_death_effect.tscn")

# jump grace
var floorer = 1.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var arrow_scene = preload("res://Projectile/arrow.tscn")
var random = RandomNumberGenerator.new()
var arrows = ["res://Art Assets/ball_red.png", "res://Art Assets/ball_blue.png",
"res://Art Assets/ball_green.png", "res://Art Assets/ball_yellow.png"]

func _physics_process(delta):	
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, down_vel_max)
		floorer = lerp(floorer, 0.0, 40*delta)
	else:
		floorer = 1.0

	if Input.is_action_just_pressed("jump")  and floorer > 0.001:
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("left", "right")
	
	if direction:
		$AnimationPlayer.play("main char")
		velocity.x = direction * SPEED
		_facing_direction = -1 if direction > 0 else 1
		#animation.play("Run")
		_was_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimationPlayer.play("stop")
		_was_moving = false
	if _was_moving:
		sprite.flip_h = (_facing_direction < 0)
	# Handle SHOOT >:)
	if Input.is_action_pressed("LMB"):
		if shoot_cd <= 0:
			shoot_cd = SHOOT_CD
			shoot()
		else:
			shoot_cd -= delta
	else:
		shoot_cd = 0
	move_and_slide()

func shoot():
	var arrowsprite = arrows[random.randi_range(0, 3)]
	var target = get_global_mouse_position()
	var start = self.global_position - Vector2(_facing_direction*10, 0) - Vector2(10, 0) # I HAVE NO IDEA WHY DID IT OFFSET TO THE RIGHT
	print(start)
	var arrow = arrow_scene.instantiate()
	arrow.sprite = arrowsprite
	arrow.global_position = start
	#arrow.rotation = (target - start).angle() + PI/2
	arrow.vel = (target - start)
	#arrow.speed = 2000
	#arrow.target = target
	owner.add_child(arrow)

func createHitEffect():
	var hitEffect = HitEffect.instantiate()
	hitEffect.global_position = global_position
	get_parent().add_child(hitEffect)
	
func createDeathEffect():
	var deathEffect = DeathEffect.instantiate()
	deathEffect.global_position = global_position
	get_parent().add_child(deathEffect)

func take_damage():
	Stats.player_hp -= 1
	if Stats.player_hp == 0:
		createDeathEffect()
		sprite.visible = false
		Stats.player_hp = Stats.START_HP
		timer.start(2)
	else:
		createHitEffect()

func _on_playehitarea_body_entered(body):
	if body.is_in_group("enemy_arrow"):
		body.queue_free()
		take_damage()

func _on_playehitarea_area_entered(area):
	take_damage()

func _on_timer_timeout():
	sprite.visible = true
	get_tree().reload_current_scene()
