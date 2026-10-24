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

func get_node_under_mouse(camera : Camera3D) -> Node:
	var mouse_pos = camera.get_viewport().get_mouse_position()
	var space_state = camera.get_world_3d().direct_space_state
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 10000.0
	
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)
	print("result: ", result)
	if result.is_empty():
		return null
		
	var collider = result.collider
	print("collider: ", collider.name)
	if collider.get_parent() is Sprite3D:
		return collider
	
	return null
	
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
