extends Node

var START_HP : int = 3
var player_hp : int = START_HP
var has_hat : bool = false

signal hat_donned

var cursor = load("res://Art Assets/crosshair.png")

func _ready():
	hat_donned.connect(hat_donned_singleton)
	Input.set_custom_mouse_cursor(cursor)

func hat_donned_singleton():
	START_HP = 5
	has_hat = true
