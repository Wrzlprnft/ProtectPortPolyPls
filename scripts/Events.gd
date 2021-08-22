extends Node

signal change_health(newHealth)

signal change_currency(delta)
signal currency_changed(newValue,ring_id)

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

signal request_pewpew()


onready var rng = RandomNumberGenerator.new()

var meteor_particle_scene = preload("res://scenes/MeteorParticles.tscn")
var meteor_sound_scene = preload("res://scenes/MeteorDeath.tscn")
var impact_sound_scene = preload("res://scenes/ImpactSound.tscn")
var station_particle_scene = preload("res://scenes/StationParticles.tscn")
