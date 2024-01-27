extends RigidBody2D

var vel = Vector2(0, 1)
@export var speed = 300.0
var sprite = "res://Art Assets/ball_red.png"
var pos_prev : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	$ArrowSprite.texture = load(sprite)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if speed > 0:
		speed -= delta*200
	else:
		speed = 0
	
	pos_prev = global_position
	move_and_collide(vel.normalized() * delta * speed)
	if (pos_prev - global_position).length() < 2:
		slow_killer(0.2)


func _on_timer_timeout():
	queue_free()


func _on_body_entered(body):
	#print(body)
	if body.is_in_group("tiles"):
		slow_killer(1)

func slow_killer(timetokill):
	var tween = get_tree().create_tween()
	tween.tween_property($ArrowSprite, "modulate", Color(1, 1, 1, 0), timetokill)
	tween.tween_callback(func(): self.queue_free())
