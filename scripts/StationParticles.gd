extends AnimatedSprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():	
	frame = Events.rng.randi_range(0,24)
	$AnimationPlayer.play("scale")
	$CPUParticles.emitting = true
	yield($AnimationPlayer,"animation_finished")
	get_parent().remove_child(self)
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
