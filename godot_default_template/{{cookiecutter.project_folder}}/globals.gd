# =============================================================================
# globals.gd
# =============================================================================
# This script manages global game settings, including audio volume, game speed,
# shadow settings, and window mode. It also handles saving and loading these
# settings.
#
# @author winkensjw
# @version 1.0
# =============================================================================

extends Node


## Save identifier for persistent data.
const SAVE_ID: String = FIXME

## Version identifier for save data.
const VERSION_ID: String = "1"



## Called when the node enters the scene.  Initializes settings.
func _ready() -> void:
	add_to_group("persistable")

	load_data()


## Gets the save identifier.
## @return The save identifier.
func get_save_id() -> String:
	return SAVE_ID


## Saves all relevant global settings.
## @return A dictionary containing the saved settings data.
func save_data() -> Dictionary:
	_log.info("Saving settings")  # Use _log here!
	var data: Dictionary = {}
	# data["example"] = "example"
	return data


## Loads all relevant global settings.
func load_data() -> void:
	var data: Dictionary = SaveManager.get_data(get_save_id())
	if data.is_empty():
		return

	# example = data.get("example", 0.0)
