extends Node2D

var current_scene

func _ready() -> void:
	Events.connect("load_complete", Callable(self, "_on_scene_changed"))
	# call this deferred as root node is not ready yet and scene manager is adding to that node
	call_deferred("_add_main_menu")
	
func _add_main_menu() -> void:
	SceneManager.change_scenes("res://scenes/main_menu/main_menu.tscn", self, null, "no_transition")
	
func _on_scene_changed(loaded_scene:Node) -> void:
	current_scene = loaded_scene
