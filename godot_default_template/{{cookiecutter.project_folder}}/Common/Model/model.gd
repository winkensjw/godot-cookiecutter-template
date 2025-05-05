## ============================================================================
## Model.gd
## ============================================================================
## Parent class for all game objects that represent a model. Contains a Data.gd
## and allows to subscribe to data changes. Provides a simplified interface
## for accessing and manipulating the underlying data store.
##
## @author winkensjw
## @version 1.0
## ============================================================================
class_name Model
extends RefCounted

var _data: Data = Data.new(self)


func is_data_changing() -> bool:
	return _data.is_data_changing()


func set_data_changing(flag: bool) -> void:
	_data.set_data_changing(flag)


func clear_data() -> void:
	_data.clear_data()


func get_data_map() -> Dictionary:
	return _data.get_data_map()


func put_data_map(map: Dictionary) -> void:
	_data.put_data_map(map)


func has_data(name: String) -> bool:
	return _data.has_data(name)


func set_data(name: String, value: Variant, default_old_value: Variant = null) -> bool:
	return _data.set_data(name, value, default_old_value)


func set_data_no_fire(name: String, value: Variant) -> bool:
	return _data.set_data_no_fire(name, value)


func set_data_always_fire(name: String, value: Variant) -> void:
	_data.set_data_always_fire(name, value)


func get_data(name: String, default_if_null: Variant = null) -> Variant:
	return _data.get_data(name, default_if_null)


func add_data_change_listener(name: String, listener: Callable) -> void:
	_data.add_data_change_listener(name, listener)


func remove_data_change_listener(name: String, listener: Callable) -> void:
	_data.remove_data_change_listener(name, listener)


func fire_data_change(name: String, old_value: Variant, new_value: Variant) -> void:
	_data.fire_data_change(name, old_value, new_value)


func has_listeners() -> bool:
	return _data.has_listeners()


func has_listeners_for(name: String) -> bool:
	return _data.has_listeners_for(name)
