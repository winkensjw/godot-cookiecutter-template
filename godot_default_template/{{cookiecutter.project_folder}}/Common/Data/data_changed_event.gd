# DataChangedEvent.gd
class_name DataChangedEvent
extends RefCounted

var source: Object
var data_name: String
var old_value: Variant
var new_value: Variant


func _init(src: Object, name: String, old_val: Variant, new_val: Variant) -> void:
	source = src
	data_name = name
	old_value = old_val
	new_value = new_val
