@tool
extends EditorPlugin

const _SelectionService = preload("res://addons/godot-node-context/services/selection_service.gd")
const _ViewportService = preload("res://addons/godot-node-context/services/viewport_service.gd")
const _ActionService = preload("res://addons/godot-node-context/services/action_service.gd")

const _ContextMenu = preload("res://addons/godot-node-context/ui/context_menu.gd")

var selection_service: _SelectionService
var viewport_service: _ViewportService
var action_service: _ActionService

var context_menu: _ContextMenu

var selected_node : Node3D

var editor_camera : Camera3D

var editor_menu : NodeContextRegistryEditorMenu

# ---------------------------------------------------------------------------

func _exit_tree():
	editor_menu._exit_tree()

# ---------------------------------------------------------------------------

func _enter_tree() -> void:
	editor_menu = NodeContextRegistryEditorMenu.new(self)
	
	var viewport_3d : SubViewport = get_editor_interface().get_editor_viewport_3d()
	var parent : Node = viewport_3d.get_parent().get_parent()
	editor_camera = viewport_3d.get_camera_3d()
	
	selection_service = _SelectionService.new(get_editor_interface())
	viewport_service = _ViewportService.new()
	action_service = _ActionService.new()
	
	context_menu = _ContextMenu.new()
	parent.add_child(context_menu)
	
	selection_service.selection_changed.connect(_on_selection_changed)
	
# ---------------------------------------------------------------------------

func _show_context_menu(handler, context : SelectionContext) -> void:
	context_menu.show_for_context(handler, context)

# ---------------------------------------------------------------------------

func _handles(object : Object) -> bool:
	return object is Node3D

# ---------------------------------------------------------------------------

func _hide_context_menu() -> void:
	context_menu.hide_context()

# ---------------------------------------------------------------------------

func _on_selection_changed(node ) -> void:
	print("_on_selection_changed: ", node)
	print("# ---------------------------------------------------------------------------")
	if !node is Node3D:
		_hide_context_menu()
		return
	
	if !_viewport_input_pending:
		_hide_context_menu()
		return 
	
	selected_node = node
	var handler = NodeContextRegistry.get_handler(selected_node)
	if handler:
		_show_context_menu(handler, action_service.create_context(selected_node))
		var pos : Vector2 = editor_camera.unproject_position(
			selected_node.global_position
		)
		context_menu.position = pos
	else:
		_hide_context_menu()
	
	_viewport_input_pending = false
	
# ---------------------------------------------------------------------------

var _viewport_input_pending := false
func _forward_3d_gui_input(viewport_camera: Camera3D, event: InputEvent) -> int:
	if event is InputEventMouseButton \
	and event.pressed:

		_viewport_input_pending = true

	return EditorPlugin.AFTER_GUI_INPUT_PASS
	
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
