extends Node

var fixture_value = 0

func _ready() -> void:
	load_data()

func save_data() -> void:
	SaveManager.save_data(_export_data())

func load_data() -> void:
	_importData(SaveManager.load_data())

func _export_data() -> Dictionary:
	return {
		"fixture_property": fixture_value
	}
	
func _import_data(data : Dictionary) -> void:
	if data.is_empty():
		print("No data to import")
		return
	fixture_value = data["fixture_property"]
