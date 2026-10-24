extends RefCounted
#ActionService

var _SelectionContext = preload("res://addons/godot-node-context/models/selection_context.gd")

var actions : Array[EditorAction] = []

# ---------------------------------------------------------------------------

func register_action(action : EditorAction) -> void:
	actions.append(action)

# ---------------------------------------------------------------------------

func get_available_actions() -> Array[EditorAction]:
	return actions

# ---------------------------------------------------------------------------

func create_context(node : Node) -> SelectionContext:
	var context = _SelectionContext.new()
	context.selected_node = node
	return context

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
