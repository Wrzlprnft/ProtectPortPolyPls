extends KinematicBody


export var velocity := 1
var target := Vector3.ZERO

var health := 3

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_reset",self,"game_reset")

func game_reset():
	get_parent().remove_child(self)
	queue_free()
	

func damage(d: int) -> void:
	health -= d
	if health <= 0:
		get_parent().remove_child(self)
		queue_free()

func _physics_process(delta):
	var vec = -to_global(target).normalized()
	look_at(target,Vector3.UP)
	var collision = move_and_collide(vec* velocity/60.0)
	
	if collision:
		Events.emit_signal("change_health",-1)
		get_parent().remove_child(self)
		queue_free()
