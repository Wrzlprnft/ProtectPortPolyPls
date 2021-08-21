extends KinematicBody

export var strut_dist := 0
export var ring_id := 1
export var start_speed := 2

var speedlevel := 2
var speed_values = [0.15,0.125,0.1,-0.1,-0.125,-0.15]

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_started",self,"teleport_rings_down")
	Events.connect("game_ended",self,"teleport_rings_up")
	Events.connect("change_speed"+str(ring_id),self,"change_speed")
	Events.connect("game_started",self,"reset_speed")
	reset_speed()
	
func reset_speed() -> void:
	speedlevel = start_speed
	Events.emit_signal("speed"+str(ring_id)+"_changed", (speedlevel - 3) if (speedlevel < 3) else (speedlevel - 2)) 

func change_speed(dir) -> void:
	speedlevel = speedlevel + dir
	speedlevel = max(min(speedlevel,5),0)
	Events.emit_signal("speed"+str(ring_id)+"_changed", (speedlevel - 3) if (speedlevel < 3) else (speedlevel - 2)) 

func teleport_rings_down() -> void:
	$Struts.translate(Vector3.DOWN * strut_dist)

func teleport_rings_up() -> void:
	$Struts.translate(Vector3.UP * strut_dist)

func _physics_process(delta):
	rotate_y(deg2rad(speed_values[speedlevel]))
	transform = transform.orthonormalized()

