extends Area


var enemies = []

var laser_scene = preload("res://scenes/Laserbeam.tscn")

var cooldown = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("game_reset",self,"game_reset")
	Events.connect("game_ended",self,"stop_firing")
	
func game_reset():
	get_parent().remove_child(self)
	queue_free()

func stop_firing() -> void:
	cooldown = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if enemies.empty():
		return
	var closest = enemies.front()
	var distance = closest.to_global(Vector3.ZERO)
	for enemy in enemies:
		var d = enemy.to_global(Vector3.ZERO)
		if d.length() < distance.length():
			closest = enemy
			distance = d
	look_at(Vector3(closest.to_global(Vector3.ZERO).x,to_global(Vector3.ZERO).y,closest.to_global(Vector3.ZERO).z),Vector3.UP)
	if cooldown == 0:
		var laserbeam = laser_scene.instance()
		get_parent().add_child(laserbeam)
		laserbeam.translate_object_local(translation)
		laserbeam.rotation = rotation
		laserbeam.fire(self,closest)
		cooldown = 1*60
	else:
		cooldown -=1

func _on_Turret_body_entered(body):
	if body.is_in_group("enemies"):
		enemies.append(body)

func _on_Turret_body_exited(body):
	if enemies.count(body) != 0:
		enemies.erase(body)
