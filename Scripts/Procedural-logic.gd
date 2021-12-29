extends Node

onready var spawnPosition = get_parent().get_node("mapSpawnPosition")

func _ready():
	loadNewScene(spawnPosition)

func loadNewScene(pSpawnPosition):
	var scenes = get_children()
	print(scenes.size())
	var scene = PackedScene.new()
	randomize()
	var i = randi() % scenes.size()
	scene.pack(scenes[i])
	print(scenes[i])
	var sceneInstance = scene.instance()
	sceneInstance.position = pSpawnPosition.get_global_position()
	call_deferred("add_child", sceneInstance)
