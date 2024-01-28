extends Control

var paused = false

func _ready():
	hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	paused = !paused
	if paused:
		hide()
		Engine.time_scale = 1
	else:
		show()
		Engine.time_scale = 0

func _on_resume_pressed():
	pauseMenu()

func _on_reset_pressed():
	pauseMenu()
	Stats.health = Stats.maxHealth
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
