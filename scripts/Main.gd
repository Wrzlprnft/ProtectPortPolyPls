extends Node

var health := 10 setget set_health

var current_mount = null
var current_ring_id = 0
var tracked_mount = null
var tracked_ring_id = 0
var mount_tracking := false

var turret_scene = preload("res://scenes/Turret.tscn")

func set_health (newHealth) -> void:
	health = newHealth
	Events.emit_signal("health_changed",health)
	
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
	Events.emit_signal("game_started")

func _input(event):
	if event is InputEventMouseButton and current_mount:
		if event.button_index == BUTTON_LEFT && event.pressed:
			tracked_mount = current_mount
			tracked_ring_id = current_ring_id
			mount_tracking = true
			Events.emit_signal("mount_selected")
			
func _process(delta):
	if mount_tracking and tracked_mount:
		var pos = tracked_mount.to_global(Vector3.ZERO)
		Events.emit_signal("mount_positon",pos)

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
	
# spawn enemies
# track health
# track currency
# turret construction
#	-> active turret mount!
#	-> building UI?
