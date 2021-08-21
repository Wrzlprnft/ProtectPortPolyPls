extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass



func _on_Pause_toggled(button_pressed):
	if button_pressed:
		get_tree().paused = true
	else:
		get_tree().paused = false
