extends EditorAction
class_name DeleteAction

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------

func get_name() -> String: 
	return "Delete"

# ---------------------------------------------------------------------------

func execute(context) -> void:
	if context.selected_node:
		context.selected_node.queue_free()
