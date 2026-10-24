@tool
extends PanelContainer
class_name ContextMenu

signal action_selected(action)

var vbox : VBoxContainer = VBoxContainer.new()

# ---------------------------------------------------------------------------

func _init() -> void:
	visible = false
	add_child(vbox)
	mouse_filter = Control.MOUSE_FILTER_STOP

# ---------------------------------------------------------------------------

func show_for_context(actions : Array):
	for child : Node in vbox.get_children():
		child.queue_free()
	
	for action : EditorAction in actions:
		var button : Button = Button.new()
		button.text = action.get_name()
		button.pressed.connect(
			func():	action_selected.emit(action)
		)
		vbox.add_child(button)
	
	visible = true

# ---------------------------------------------------------------------------

func hide() -> void:
	visible = false
	
# ---------------------------------------------------------------------------

func _on_button_pressed(action):
	visible = false
	action_selected.emit(action)

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
