extends Node2D

@onready var player = $Player
var splashscreen = preload("res://UI/EndSplash.tscn")

func _ready():
	player.SPEED = 0
	player.JUMP_VELOCITY = 0


func _on_text_box_dialog_end():
	var splashscreen_inst = splashscreen.instantiate()
	splashscreen_inst.global_position = $Camera2D2.global_position
	splashscreen_inst.scale = Vector2(1/$Camera2D2.zoom.x, 1/$Camera2D2.zoom.y)
	add_child(splashscreen_inst)
	player.the_end = true
