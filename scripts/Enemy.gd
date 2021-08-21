extends KinematicBody


export var velocity := 1
var target := Vector3.ZERO

var rot_speed := 0.0
var rot_angle := Vector3.UP

var health := 3

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_reset",self,"game_reset")
	var x = Events.rng.randf_range(0.8,1.2)
	var y = Events.rng.randf_range(0.8,1.2)
	var z = Events.rng.randf_range(0.8,1.2)
	scale_object_local(Vector3(x,y,z))
	x = Events.rng.randf_range(0.1,1)
	y = Events.rng.randf_range(0.1,1)
	z = Events.rng.randf_range(0.1,1)
	rot_angle = Vector3(x,y,z).normalized()
	rot_speed = deg2rad(Events.rng.randf_range(0.0,360.0))/60.0

func game_reset():
	die()
	
func die() -> void:
	var particles = Events.meteor_particle_scene.instance()
	get_parent().add_child(particles)
	particles.translate_object_local(translation)
	get_parent().remove_child(self)
	queue_free()

func damage(d: int) -> void:
	health -= d
	if health <= 0:
		Events.emit_signal("change_currency",1)
		die()

func _physics_process(delta):
	var vec = -to_global(target).normalized()
	rotate(rot_angle,rot_speed)
	var collision = move_and_collide(vec* velocity/60.0)
	
	if collision:		
		Events.emit_signal("change_health",-1)
		var particles = Events.station_particle_scene.instance()
		get_parent().add_child(particles)
		particles.translate_object_local(collision.position)
		die()
