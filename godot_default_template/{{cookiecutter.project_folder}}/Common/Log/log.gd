# =============================================================================
# Log
# =============================================================================
# This script provides a logging mechanism.
#
# @author winkensjw
# @version 1.0
# =============================================================================
class_name Log
extends RefCounted

var logger_name: String


## Constructor that takes a string class_name and stores it in logger_name.
func _init(name: String, log_level: ConsoleAdapter.LogLevel = ConsoleAdapter.LogLevel.NONE) -> void:
	logger_name = name
	if log_level != ConsoleAdapter.LogLevel.NONE:
		ConsoleAdapter.set_log_level(name, log_level)


## Getter for logger_name. No setter is provided.
func get_logger_name() -> String:
	return logger_name


## Logs an error message with the given text.
## @param text The text to log as an error.
func error(text: Variant) -> void:
	if ConsoleAdapter.is_log_level(logger_name, ConsoleAdapter.LogLevel.ERROR):
		ConsoleAdapter.error("[" + get_logger_name() + "] " + str(text))


## Logs an info message with the given text.
## @param text The text to log as an info.
func info(text: Variant) -> void:
	if ConsoleAdapter.is_log_level(logger_name, ConsoleAdapter.LogLevel.INFO):
		ConsoleAdapter.info("[" + get_logger_name() + "] " + str(text))


## Logs a warning message with the given text.
## @param text The text to log as a warning.
func warn(text: Variant) -> void:
	if ConsoleAdapter.is_log_level(logger_name, ConsoleAdapter.LogLevel.WARN):
		ConsoleAdapter.warning("[" + get_logger_name() + "] " + str(text))


## Logs a debug message with the given text.
## @param text The text to log as a debug message.
func debug(text: Variant) -> void:
	if ConsoleAdapter.is_log_level(logger_name, ConsoleAdapter.LogLevel.DEBUG):
		ConsoleAdapter.debug("[" + get_logger_name() + "] " + str(text))
