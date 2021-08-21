extends CPUParticles


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	yield(get_tree().create_timer(lifetime), "timeout")
	get_parent().remove_child(self)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
