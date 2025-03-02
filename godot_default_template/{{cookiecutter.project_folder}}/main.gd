extends Node2D

var current_scene : Node

func _ready() -> void:
	Events.load_complete.connect(_on_scene_changed)
	Events.main_menu_closed.connect(_on_main_menu_closed)
	# call this deferred as root node is not ready yet and scene manager is adding to that node
	_add_main_menu.call_deferred()
	
func _add_main_menu() -> void:
	SceneManager.change_scenes("Entities/MainMenu/main_menu.tscn", self, null, "no_transition")
	
func _on_scene_changed(loaded_scene : Node) -> void:
	current_scene = loaded_scene
	
func _on_main_menu_closed() -> void:
	SceneManager.change_scenes("Entities/Game/game.tscn", self, current_scene)
