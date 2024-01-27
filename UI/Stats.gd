extends Node

var START_HP : int = 3
var player_hp : int = START_HP

var cursor = load("res://Art Assets/crosshair.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor)
