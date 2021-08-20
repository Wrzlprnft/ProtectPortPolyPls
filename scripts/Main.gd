extends Node

var health := 10 setget set_health

func set_health (newHealth) -> void:
	health = newHealth
	Events.emit_signal("health_changed",health)
	
func change_health(delta) -> void:
	set_health(health + delta)


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.emit_signal("game_started")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# spawn enemies
# track health
# track currency
# turret construction
