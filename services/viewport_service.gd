@tool
extends RefCounted
#ViewportService

const CLICK_RADIUS : float = 16.0

signal gizmo_clicked( node : Node3D, camera : Camera3D, screen_position : Vector2)

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------

func process_input(event : InputEvent) -> bool:
	return (event is InputEventMouseButton and event.pressed)
	
# ---------------------------------------------------------------------------

func get_menu_position( node : Node3D, camera : Camera3D) -> Vector2:
	var pos = Vector2.ZERO
	if node:
		pos = node.global_position
	
	return camera.unproject_position(node.global_position)

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
