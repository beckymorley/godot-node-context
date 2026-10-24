extends Node
class_name NodeContextRegistryEditorMenu

var button : Button
var plugin : EditorPlugin

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------

func _init(p_plugin : EditorPlugin) -> void:
	plugin = p_plugin
	button = Button.new()
	button.text = "Update Contexts"
	button.pressed.connect(_on_button_pressed)
	plugin.add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, button)

	NodeContextRegistry.discover_handlers("res://editor_tools/context_handlers")
	
# ---------------------------------------------------------------------------

func _exit_tree() -> void:
	plugin.remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, button)

# ---------------------------------------------------------------------------

func _on_button_pressed():
	NodeContextRegistry.discover_handlers("res://editor_tools/context_handlers")

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
