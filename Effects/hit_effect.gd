extends AnimatedSprite2D

func _ready():
	connect("animation_finished", onAnimationFinished)
	play("default")

func onAnimationFinished():
	queue_free()
