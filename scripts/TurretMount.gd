extends StaticBody

export var ring_id = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TurretMount_mouse_entered():
	Events.emit_signal("mount_entered",$Position,ring_id)


func _on_TurretMount_mouse_exited():
	Events.emit_signal("mount_exited",$Position)
