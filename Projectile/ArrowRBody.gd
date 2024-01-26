extends RigidBody2D

var vel = Vector2(0, 1)
@export var speed = 600.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if speed > 0:
		speed -= delta
	
	
	move_and_collide(vel.normalized() * delta * speed)
	pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
