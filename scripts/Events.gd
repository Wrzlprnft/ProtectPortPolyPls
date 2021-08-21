extends Node

signal change_health(newHealth)

signal change_currency(delta)
signal currency_changed(newValue)

signal start_game()
signal game_started()
signal game_reset()
signal game_ended()

signal mount_entered(mount,ring_id)
signal mount_exited(mount)
signal mount_positon(pos)
signal mount_selected()
signal mount_deselected()
signal build_turret(id)

signal update_time(value)

signal change_speed1(dir)
signal change_speed2(dir)
signal change_speed3(dir)

signal speed1_changed(new_value)
signal speed2_changed(new_value)
signal speed3_changed(new_value)

signal fully_armed_and_operational()


onready var rng = RandomNumberGenerator.new()

var meteor_particle_scene = preload("res://scenes/MeteorParticles.tscn")
var station_particle_scene = preload("res://scenes/StationParticles.tscn")
