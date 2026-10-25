@tool
extends RefCounted
#SelectionService

signal selection_changed(node : Node)

var selection : EditorSelection
var selected_node : Node

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------

func _init(p_editor : EditorInterface) -> void:
	selection = p_editor.get_selection()
	print("EditorSelection: ", selection)
	selection.selection_changed.connect(_on_selection_changed)

# ---------------------------------------------------------------------------

func _on_selection_changed() -> void:
	var nodes = selection.get_selected_nodes()
	if nodes.size() > 0:
		selected_node = nodes[0]
	else:
		selected_node = null
		
	selection_changed.emit(selected_node)

# ---------------------------------------------------------------------------

func get_selected_node() -> Node:
	return selected_node
	
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
