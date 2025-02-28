extends Node

const SAVE_LOCATION = "user://{{cookiecutter.project_folder}}.save"

func _ready() -> void:
	load_data()

func save_data(data : Dictionary) -> void:
	_write_save_file(data)

func load_data() -> Dictionary:
	return _load_save_file()
	
func _write_save_file(data : Dictionary) -> void:
	var save_file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	save_file.store_line(json_string)
	
func _load_save_file() -> Dictionary:
	if not FileAccess.file_exists(SAVE_LOCATION):
		return {}
	
	var save_file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		push_error("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return {}
	return json.data
