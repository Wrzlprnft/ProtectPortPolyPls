extends Node

var running = false

var health := 10 setget set_health

var time := 0.0

var current_mount = null
var current_ring_id = 0
var tracked_mount = null
var tracked_ring_id = 0
var mount_tracking := false

var turret_scene = preload("res://scenes/Turret.tscn")
var meteor_scene = preload("res://scenes/Enemy.tscn")

onready var rng = RandomNumberGenerator.new()

func set_health (newHealth) -> void:
	if newHealth == 0:
		health = newHealth
		end_game()
	elif health > 0:
		health = newHealth
	$MenuBar/VBoxContainer/Healthbox/Value.bbcode_text = "[right]" + str(health) + "[/right]"
	
func change_health(delta) -> void:
	set_health(health + delta)

func set_current_mount(mount,ring_id) -> void:
	current_mount = mount
	current_ring_id = ring_id
	
func clear_current_mount(mount) -> void:
	current_mount = null
	
func clear_mount_tracking() -> void:
	tracked_ring_id = 0
	tracked_mount = null
	mount_tracking = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("mount_entered",self,"set_current_mount")
	Events.connect("mount_exited",self,"clear_current_mount")
	Events.connect("mount_deselected",self,"clear_mount_tracking")
	Events.connect("build_turret",self,"build_turret")
	Events.connect("change_health",self,"change_health")
	rng.randomize()
	start_game()
	while(true):
		spawn_meteor()
		yield(get_tree().create_timer(1), "timeout")

func _input(event):
	if event is InputEventMouseButton and current_mount and running:
		if event.button_index == BUTTON_LEFT && event.pressed:
			tracked_mount = current_mount
			tracked_ring_id = current_ring_id
			mount_tracking = true
			Events.emit_signal("mount_selected")
			
func _process(delta):
	if mount_tracking and tracked_mount:
		var pos = tracked_mount.to_global(Vector3.ZERO)
		Events.emit_signal("mount_positon",pos)
	if running:
		time += delta
		Events.emit_signal("update_time",time)

func build_turret(id) -> void:
	var turret = turret_scene.instance()
	var ring = $ViewportContainer/Viewport/Ring1
	match tracked_ring_id:
		2:
			ring = $ViewportContainer/Viewport/Ring2
		3:
			ring = $ViewportContainer/Viewport/Ring3
	ring.add_child(turret)
	turret.translate(ring.to_local(tracked_mount.to_global(Vector3.ZERO)))
	
func spawn_meteor() -> void:
	if not running:
		return
	var meteor = meteor_scene.instance()
	var spawnpoint = Vector3(-10,0,0)
	spawnpoint = spawnpoint.rotated(Vector3.UP,rng.randf_range(0.0,2* PI))
	meteor.translate(spawnpoint)
	$ViewportContainer/Viewport.add_child(meteor)
	
func start_game() -> void:
	Events.emit_signal("start_game")
	set_health(10)
	time = 0.0
	yield(Events,"game_started")
	running = true
	
func end_game() -> void:
	running = false
	Events.emit_signal("game_ended")
	
