extends Node

var cursor = load("res://Art Assets/crosshair.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor)

signal no_health
signal health_changed(value)
signal max_health_changed(value)

@export var maxHealth: int = 3:
	set(value):
		maxHealth = value
		health = min(health, maxHealth)
		max_health_changed.emit(maxHealth)

@onready var health: int = maxHealth:
	set(value):
		health = value
		health_changed.emit(health)
