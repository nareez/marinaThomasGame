extends Node2D

onready var spawnPosition = $spawnPosition

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ProceduralLogic_body_exited(body):
	var scene = load("res://Scenes/procedural-scenes/proc-map-01.tscn")
	var sceneInstance = scene.instance()
	sceneInstance.position = spawnPosition.get_global_position()
	get_parent().add_child(sceneInstance)
