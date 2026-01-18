extends Node

# --- Signals ---
signal tracking_completed(status: String)

const _IOS_PLUGIN_NAME: String = "GodotAttIosPlugin"

var _plugin: Object = null

func _ready() -> void:
	if Engine.has_singleton(_IOS_PLUGIN_NAME):
		_plugin = Engine.get_singleton(_IOS_PLUGIN_NAME)
		_log_to_console("ATT plugin found.")
	else:
		_log_to_console("ATT Plugin not found. This is normal if you are not on iOS.")
		return

	if _plugin.has_signal("tracking_request_completed"):
		_plugin.tracking_request_completed.connect(func(status: String) -> void:
			_log_to_console("Received status from plugin: " + status)
			tracking_completed.emit(status)
		)
	else:
		_log_to_console("ERROR: tracking_request_completed signal not found in native plugin")

# --- Public API for Godot ---

func request_tracking() -> void:
	if not _is_plugin_ready(): return
	
	_log_to_console("Calling request_tracking in native plugin...")
	_plugin.request_tracking()


func can_show_request_dialog() -> bool:
	if not _is_plugin_ready(): return false
	
	return _plugin.can_show_request_dialog()


func get_idfa() -> String:
	if not _is_plugin_ready(): return "00000000-0000-0000-0000-000000000000"
	return _plugin.get_idfa()


func debug_hello_world() -> void:
	if not _is_plugin_ready(): return
	_plugin.hello_world()

# --- Private Helper Methods ---

func _is_plugin_ready() -> bool:
	if _plugin == null:
		_log_to_console("ATT plugin is null")
		return false
	return true

func _log_to_console(log_text: String) -> void:
	print("[ATTManager]: ", log_text)
