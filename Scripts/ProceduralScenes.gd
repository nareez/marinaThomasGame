extends Area2D

onready var spawn = $SpawnPoint
export (PackedScene) var scenes

func _on_ProceduralScenes_body_entered(body):
	scenes = load("res://Scenes/procedural-scenes/proc-map-01.tscn")
	var sceneInstance = scenes.instance()
	sceneInstance.position.x = spawn.position.x
	get_parent().add_child(sceneInstance)
