@tool
extends EditorPlugin

const _SelectionService = preload("res://addons/godot-node-context/services/selection_service.gd")
const _ViewportService = preload("res://addons/godot-node-context/services/viewport_service.gd")
const _ActionService = preload("res://addons/godot-node-context/services/action_service.gd")

const _ContextMenu = preload("res://addons/godot-node-context/ui/context_menu.gd")

const _DuplicateAction = preload("res://addons/godot-node-context/actions/duplicate_action.gd")
const _FocusAction = preload("res://addons/godot-node-context/actions/focus_action.gd")
const _DeleteAction = preload("res://addons/godot-node-context/actions/delete_action.gd")

var selection_service: _SelectionService
var viewport_service: _ViewportService
var action_service: _ActionService

var context_menu: _ContextMenu

var selected_node : Node3D

var editor_camera : Camera3D

var overlay_root: Control

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
	context_menu.action_selected.connect(_on_action_selected)
	
# ---------------------------------------------------------------------------

func _show_context_menu(actions : Array) -> void:
	context_menu.show_for_context(actions)

# ---------------------------------------------------------------------------

func _hide_context_menu() -> void:
	context_menu.hide()

# ---------------------------------------------------------------------------

func _on_selection_changed(node : Node) -> void:
	print("_on_selection_changed", node)
	print("# ---------------------------------------------------------------------------")
	if !node:
		_hide_context_menu()
		return

	var handler = NodeContextRegistry.get_handler(node)
	print("handler: ", handler)
	if handler:
		_show_context_menu(NodeContextRegistry.get_actions(node))
		var pos : Vector2 = editor_camera.unproject_position(
			node.global_position
		)
		context_menu.position = pos
	else:
		_hide_context_menu()

# ---------------------------------------------------------------------------

func _on_action_selected(action : EditorAction) -> void:
	action.execute(
		action_service.create_context(selected_node)
	)

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
