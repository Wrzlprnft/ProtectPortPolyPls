extends Spatial


var origin
var target


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fire(o,t) -> void:
	origin = o
	target = t
	var s = Vector3(1.0,1.0,to_local(target.to_global(Vector3.ZERO)).length())
	scale_object_local(s)
	look_at(target.to_global(Vector3.ZERO),Vector3.UP)
	if t:
		t.damage(1)
	yield(get_tree().create_timer(0.2), "timeout")
	get_parent().remove_child(self)
	queue_free()
	
