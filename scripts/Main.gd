extends Node

var running = false

var health := 10 setget set_health
var currency := 5 setget set_currency
var difficulty := 1
var difficulty_increase := 6

var time := 0.0

var cooldown := 0.0
var start_cooldown := 160
var spawn_cooldown := 160

var current_mount = null
var current_ring_id = 0
var tracked_mount = null
var tracked_ring_id = 0
var mount_tracking := false

var paused := false

var turret_scene = preload("res://scenes/Turret.tscn")
var meteor_scene = preload("res://scenes/Enemy.tscn")


func set_health (newHealth) -> void:
	if newHealth <= 0 and running:
		health = newHealth
		end_game()
	elif newHealth > 0:
		health = newHealth
	$MenuBar/VBoxContainer2/TabContainer/Buttons/VBoxContainer/Healthbox/Value.bbcode_text = "[right]" + str(newHealth) + "[/right]"
	
func change_health(delta) -> void:
	set_health(health + delta)
	
func set_currency(newValue):
	currency = newValue
	Events.emit_signal("currency_changed",currency,tracked_ring_id)
	
func change_currency(delta):
	set_currency(currency + delta)

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
	OS.min_window_size = Vector2(800, 480)
	Events.connect("mount_entered",self,"set_current_mount")
	Events.connect("mount_exited",self,"clear_current_mount")
	Events.connect("mount_deselected",self,"clear_mount_tracking")
	Events.connect("build_turret",self,"build_turret")
	Events.connect("change_health",self,"change_health")
	Events.connect("change_currency",self,"change_currency")
	Events.connect("request_pewpew",self, "laser_sound")
	Events.rng.randomize()
	$Menu.play()
	$Menu.stream_paused = false
	$Menu.volume_db = -15
	$Background.play()
	$Background.stream_paused = true
	$Background.volume_db = -80

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
		Events.emit_signal("currency_changed",currency,tracked_ring_id)
		Events.emit_signal("mount_positon",pos)
	if running:
		time += delta
		Events.emit_signal("update_time",time)
		if time > difficulty * 10.0:
			difficulty += 1
			spawn_cooldown = max(start_cooldown - difficulty * difficulty_increase,10)
			difficulty_increase += 1
		
func _physics_process(delta):
	if cooldown == 0:
		spawn_meteor()
		cooldown = spawn_cooldown
	else:
		cooldown -=1
		
func check_currency() -> void:
	change_currency(0)

func build_turret(id) -> void:
	change_currency(-5)
	tracked_mount.get_parent().get_node("CollisionShape").disabled = true
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
	var spawnpoint = Vector3(-20,0,0)
	spawnpoint = spawnpoint.rotated(Vector3.UP,Events.rng.randf_range(0.0,2* PI))
	meteor.translate(spawnpoint)
	$ViewportContainer/Viewport.add_child(meteor)
	
func laser_sound() -> void:
	if not $Laser1.playing:
		$Laser1.play()
	elif not $Laser2.playing:
		$Laser2.play()
	elif not $Laser3.playing:
		$Laser3.play()	
	elif not $Laser4.playing:
		$Laser4.play()
	
func start_game() -> void:
	set_health(10)
	set_currency(5)
	time = 0.0
	spawn_cooldown = start_cooldown
	if not running:
		Events.emit_signal("start_game")
		$AnimationPlayer.play("fadetogame")
		yield(Events,"game_started")
		running = true	
	
func end_game() -> void:
	running = false
	Events.emit_signal("game_ended")
	$AnimationPlayer.play_backwards("fadetogame")
	


func _on_Exit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_Start_pressed():
	if get_tree().paused:
		get_tree().paused = false
		$MenuBar/VBoxContainer/Pause.pressed = false
	Events.emit_signal("game_reset")
	start_game()
