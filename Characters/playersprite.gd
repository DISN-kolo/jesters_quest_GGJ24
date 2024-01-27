extends Sprite2D

var remember_offset : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	remember_offset = self.offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.flip_h:
		self.offset = remember_offset - Vector2(8, 0)
	else:
		self.offset = remember_offset
	pass
