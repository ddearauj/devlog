extends Node2D

var preloaded_enemy = preload("res://Enemy/Enemy.tscn")

onready var timer = $SpawnTimer
var spawn_in_n_seconds = 3

func _ready():
	randomize()
	timer.start(spawn_in_n_seconds)


func _on_SpawnTimer_timeout():

	var enemy = preloaded_enemy.instance()
	enemy.position = position
	get_tree().current_scene.add_child(enemy)
	
	timer.start(spawn_in_n_seconds)
	
	
