extends Spatial


var origin
var target


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func fire(o,t) -> void:
	origin = o
	target = t
	var tv = target.to_global(Vector3.ZERO)
	#tv.y = to_global(Vector3.ZERO).y
	var s = Vector3(1.0,1.0,to_local(tv).length())
	$Sprite3D.scale_object_local(s)
	$Sprite3D2.scale_object_local(s)
	$Sprite3D.look_at(tv,Vector3.UP)
	$Sprite3D2.look_at(tv,Vector3.UP)
	Events.emit_signal("request_pewpew")
	if t:
		t.damage(1)
	$AnimationPlayer.play("fade")
	yield($AnimationPlayer,"animation_finished")
	get_parent().remove_child(self)
	queue_free()
	
