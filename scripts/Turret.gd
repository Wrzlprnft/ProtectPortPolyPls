extends Area


var enemies = []

var laser_scene = preload("res://scenes/Laserbeam.tscn")

var cooldown = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		add_child(laserbeam)
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
