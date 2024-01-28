extends Node

var has_hat : bool = false

signal hat_donned
signal health_changed(value)
signal max_health_changed(value)
signal menu_paused

#var cursor = load("res://Art Assets/crosshair.png")

@export var maxHealth: int = 3:
	set(value):
		maxHealth = value
		health = min(health, maxHealth)
		max_health_changed.emit(maxHealth)

@onready var health: int = maxHealth:
	set(value):
		health = value
		health_changed.emit(health)

func _ready():
	hat_donned.connect(hat_donned_singleton)
	#Input.set_custom_mouse_cursor(cursor)

func hat_donned_singleton():
	maxHealth = 5
	has_hat = true
