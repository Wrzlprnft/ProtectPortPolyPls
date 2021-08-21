extends StaticBody

export var ring_id = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_reset",self,"reenable_mount")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reenable_mount() -> void:
	$CollisionShape.disabled = false

func _on_TurretMount_mouse_entered():
	Events.emit_signal("mount_entered",$Position,ring_id)


func _on_TurretMount_mouse_exited():
	Events.emit_signal("mount_exited",$Position)
