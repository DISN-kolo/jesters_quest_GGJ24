extends HBoxContainer

var maxHearts = 3
var hearts = maxHearts

func _ready():
	maxHearts = Stats.maxHealth
	hearts = Stats.health
	update_hearts()
	Stats.health_changed.connect(setHearth)
	Stats.max_health_changed.connect(maxHearth)

func setHearth(value):
	hearts = value
	update_hearts()

func maxHearth(value):
	maxHearts = value
	update_hearts()

func update_hearts():
	for i in get_child_count():
		get_child(i).visible = hearts > i
