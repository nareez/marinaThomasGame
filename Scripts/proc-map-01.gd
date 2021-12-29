extends Node2D

onready var spawnPosition = $NextSceneSpawnPosition

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_ProceduralLogic_body_exited(_body):
	get_parent().call_deferred("loadNewScene", spawnPosition)
	
