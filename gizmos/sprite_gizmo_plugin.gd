@tool
extends EditorNode3DGizmoPlugin
class_name SpriteGizmoPlugin

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------

func _get_gizmo_name() -> String:
	return "SpriteContextMenu"

# ---------------------------------------------------------------------------

func _has_gizmo(node: Node) -> bool:
	return node is Sprite3D

# ---------------------------------------------------------------------------

func _redraw(gizmo) -> void:
	gizmo.clear()
	
	if get_material("icon", gizmo) == null:
		create_material("icon", Color.CYAN, false, true, false)
	
	gizmo.add_unscaled_billboard(
		get_material("icon", gizmo),
		0.15, 
		Color(0.0, 2.0, 0.0)
	)

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
