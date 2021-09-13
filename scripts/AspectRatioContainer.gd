extends AspectRatioContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.connect("size_changed",self,"resize")
	resize()


func resize():
	var x : float = OS.get_window_safe_area().size.x
	var y : float = OS.get_window_safe_area().size.y
	var m : float = y/x
	var l := (1.0 - m) * 0.5 
	size_flags_stretch_ratio = (1.0/l)*m
	print(size_flags_stretch_ratio)
