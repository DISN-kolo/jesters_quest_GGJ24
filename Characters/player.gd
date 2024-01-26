extends CharacterBody2D


@export var SPEED = 200.0
@export var JUMP_VELOCITY = -300.0
@export var down_vel_max = 400.0

# jump grace
var floorer = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var arrow_scene = preload("res://Projectile/arrow.tscn")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = min(velocity.y, down_vel_max)
		floorer = lerp(floorer, 0.0, 40*delta)
	else:
		floorer = 1.0

	# Handle jump.
	if Input.is_action_just_pressed("jump")  and floorer > 0.001:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle SHOOT >:)
	if Input.is_action_just_pressed("LMB"):
		shoot()
	move_and_slide()

func shoot():
	var target = get_global_mouse_position()
	var start = self.global_position
	var arrow = arrow_scene.instantiate()
	arrow.global_position = start
	arrow.rotation = (target - start).angle() + PI/2
	arrow.vel = (target - start)
	#arrow.speed = 2000
	#arrow.target = target
	owner.add_child(arrow)
	
