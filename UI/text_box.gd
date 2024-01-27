extends Control

@export var dialogPath = ""
@export var textSpeed: float = 0.05

@onready var timer = $ColorRect/Timer
@onready var labelName = $ColorRect/Name
@onready var labelText = $ColorRect/Text
@onready var indicator = $ColorRect/Indicator

var dialog

var actual_phrase = 0
var end = false

signal dialog_end

func _ready():
	timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()

func _process(delta):
	indicator.visible = end
	if Input.is_action_just_pressed("ui_accept"):
		if end:
			nextPhrase()
		else:
			labelText.visible_characters = len(labelText.text)

func getDialog():
	var f = FileAccess.open(dialogPath, FileAccess.READ)
	var json_str = f.get_as_text()
	var json = JSON.new()
	var error = json.parse(json_str)
	if error == OK:
		var output = json.data
		if typeof(output) == TYPE_ARRAY:
			return (output)
		else:
			return []

func nextPhrase():
	if actual_phrase >= len(dialog):
		dialog_end.emit()
		queue_free()
		return
	end = false
	labelName.text = dialog[actual_phrase].name
	labelText.text = dialog[actual_phrase].text
	
	labelText.visible_characters = 0
	while labelText.visible_characters < len(labelText.text):
		labelText.visible_characters += 1
		timer.start()
		await timer.timeout
	end = true
	actual_phrase += 1
	return
