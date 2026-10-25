@tool
extends PanelContainer
class_name ContextMenu

signal action_selected(action)

var vbox : VBoxContainer = VBoxContainer.new()

# ---------------------------------------------------------------------------

func _init() -> void:
	visible = false
	add_child(vbox)
	
# ---------------------------------------------------------------------------

func show_for_context(handler : NodeContextHandler, selection_context: SelectionContext):
	_clear()
	
	handler.selection_context = selection_context
	var actions : Array[EditorAction] = handler.get_actions()
	for action : EditorAction in actions:
		var children : Array[Node] = vbox.get_children()
		if !children.has(action.control):
			vbox.add_child(action.control)
	
	visible = true
	
# ---------------------------------------------------------------------------

func _clear() -> void:
	var children_to_remove : Array[Node] = vbox.get_children().duplicate()
	for child : Node in children_to_remove:
		vbox.remove_child(child)
		child.queue_free()

# ---------------------------------------------------------------------------

func hide_context() -> void:
	_clear()
	visible = false

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
