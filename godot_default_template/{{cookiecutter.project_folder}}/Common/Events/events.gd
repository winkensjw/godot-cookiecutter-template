extends Node

# Scene Manager
signal load_start(loading_screen)
signal scene_added(loaded_scene:Node,loading_screen)
signal load_complete(loaded_scene:Node)
signal transition_in_complete

signal _scene_finished_loading(scene)
signal _scene_invalid(scene_path:String)
signal _scene_failed_to_load(scene_path:String)

# Add events here
