extends KinematicBody

export var rot_degrees := 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	rotate_y(deg2rad(rot_degrees))
