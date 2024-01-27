extends RigidBody2D

var vel = Vector2(0, 1)
@export var speed = 600.0
var sprite = "res://Art Assets/ball_red.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ArrowSprite.texture = load(sprite)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if speed > 0:
		speed -= delta*200
	else:
		speed = 0
	
	
	move_and_collide(vel.normalized() * delta * speed)
	
	pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
