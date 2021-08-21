extends KinematicBody


export var velocity := 1
var target := Vector3.ZERO

var health := 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var vec = -to_global(target).normalized()
	look_at(target,Vector3.UP)
	var collider = move_and_collide(vec* velocity/60.0)
	
	if collider:
		translate(Vector3(11.0,0.0,0.0))
