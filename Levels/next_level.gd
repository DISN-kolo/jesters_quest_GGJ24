extends Area2D

const FILE_BEGIN = "res://Levels/Level"
const FILE_EXT = ".tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		var next_level_number = get_tree().current_scene.scene_file_path.to_int() + 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_EXT
		get_tree().change_scene_to_file(next_level_path)
