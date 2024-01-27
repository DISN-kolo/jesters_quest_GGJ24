extends Node2D

@onready var player = $Player

func _ready():
	player.SPEED = 0
	player.JUMP_VELOCITY = 0


func _on_text_box_dialog_end():
	player.SPEED = 180
	player.JUMP_VELOCITY = -400
