extends KinematicBody

export var rot_degrees := 0.1
export var strut_dist := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_started",self,"teleport_rings_down")
	Events.connect("game_stopped",self,"teleport_rings_up")

func teleport_rings_down() -> void:
	$Struts.translate(Vector3.DOWN * strut_dist)

func teleport_rings_up() -> void:
	$Struts.translate(Vector3.UP * strut_dist)

func _physics_process(delta):
	rotate_y(deg2rad(rot_degrees))
