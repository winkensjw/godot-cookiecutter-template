# Data.gd
# FIXME add comments for this, add own git repo for this
class_name Data
extends RefCounted

var _log: Log = Log.new("Data")

var _source: Object
var _data: Dictionary[String, Variant] = {}
var _listeners: Dictionary[String, Array] = {}
var _data_changing: int = 0
var _event_buffer: Array[DataChangedEvent] = []


func _init(source_obj: Object) -> void:
	_source = source_obj


func is_data_changing() -> bool:
	return _data_changing > 0


func set_data_changing(flag: bool) -> void:
	if flag:
		_data_changing += 1
	else:
		if _data_changing > 0:
			_data_changing -= 1
			if _data_changing == 0:
				_process_change_buffer()


func clear_data() -> void:
	_data.clear()


func get_data_map() -> Dictionary[String, Variant]:
	return _data.duplicate(true)


func put_data_map(map: Dictionary[String, Variant]) -> void:
	for key: Variant in map.keys():
		_data[key] = map[key]


func has_data(name: String) -> bool:
	return _data.has(name)


func set_data(name: String, value: Variant, default_old_value: Variant = null) -> bool:
	var old_value: Variant = _data.get(name, default_old_value)
	_data[name] = value
	if old_value == value:
		return false
	_fire_data_change(name, old_value, value)
	return true


func set_data_no_fire(name: String, value: Variant) -> bool:
	var old_value: Variant = _data.get(name)
	_data[name] = value
	return old_value != value


func set_data_always_fire(name: String, value: Variant) -> void:
	var old_value: Variant = _data.get(name)
	_data[name] = value
	_fire_data_change(name, old_value, value)


func get_data(name: String, default_if_null: Variant = null) -> Variant:
	var data: Variant = _data.get(name, default_if_null)
	return data


func add_data_change_listener(name: String, listener: Callable) -> void:
	var listeners: Array[Callable] = _get_listeners_for(name)
	if listener not in listeners:
		listeners.append(listener)
		_log.debug("[%s] Added listener to '%s'. Listener: %s" % [_source.get_instance_id(), name, listener])
	else:
		_log.warn("[%s] Listener already exists for '%s'. Listener: %s" % [_source.get_instance_id(), name, listener])

	_set_listeners_for(name, listeners)


func remove_data_change_listener(name: String, listener: Callable) -> void:
	var listeners: Array[Callable] = _get_listeners_for(name)
	listeners.erase(listener)
	_log.debug("[%s] Removed listener from '%s'. Listener: %s" % [_source.get_instance_id(), name, listener])

	_set_listeners_for(name, listeners)


func fire_data_change(name: String, old_value: Variant, new_value: Variant) -> void:
	_log.debug("[%s] Firing data change manually for '%s'. Old Value: %s, New Value: %s" % [_source.get_instance_id(), old_value, name, new_value])
	_fire_data_change(name, old_value, new_value)


func _fire_data_change(name: String, old_value: Variant, new_value: Variant) -> void:
	var event: DataChangedEvent = DataChangedEvent.new(_source, name, old_value, new_value)
	if is_data_changing():
		_log.debug("[%s] Adding data changed event to buffer '%s'. Old Value: %s, New Value: %s" % [_source.get_instance_id(), name, old_value, new_value])
		_event_buffer.append(event)
	else:
		var targets: Array[Callable] = _get_listeners_for(name)
		_log.debug("[%s] Firing data changed event for '%s'. Old Value: %s, New Value: %s, Listeners: %s" % [_source.get_instance_id(), name, old_value, new_value, targets.size()])

		for listener in targets:
			listener.call(event)


func _process_change_buffer() -> void:
	if _event_buffer.is_empty():
		return
	var seen: Dictionary = {}
	var coalesced: Array[DataChangedEvent] = []
	for i in range(_event_buffer.size()):
		var e: DataChangedEvent = _event_buffer[i]
		if not seen.has(e.data_name):
			seen[e.data_name] = true
			coalesced.push_front(e)
	_event_buffer.clear()
	for e: DataChangedEvent in coalesced:
		_fire_data_change(e.data_name, e.old_value, e.new_value)


func has_listeners() -> bool:
	return _listeners.size() > 0


func has_listeners_for(name: String) -> bool:
	return _get_listeners_for(name).size() > 0


func _get_listeners_for(name: String) -> Array[Callable]:
	var listeners: Array[Callable]
	listeners.assign(_listeners.get(name, []))
	return listeners


func _set_listeners_for(name: String, listeners: Array[Callable]) -> void:
	_listeners.set(name, listeners)
