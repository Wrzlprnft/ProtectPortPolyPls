extends AspectRatioContainer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#get_tree().connect("screen_resized",self,"resize")
	#resize()
	pass

# HACK: adjust strech ratio of 3D game area based on width/height ratio so it stays quadratic
func _process(_delta):
	var x : float = OS.get_window_safe_area().size.x
	var y : float = OS.get_window_safe_area().size.y
	var m : float = y/x
	var l := max(abs((1.0 - m) * 0.5),0.0001)
	if get_tree().root.get_node("Main").running :
		#get_parent().anchor_left = 0
		size_flags_stretch_ratio = (1.0/l)*m
		ratio = 1
	else:
		#get_parent().anchor_left = -0.4
		size_flags_stretch_ratio = 2
		ratio = rect_size.x/y
	
