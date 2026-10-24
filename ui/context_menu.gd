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

func show_for_context(actions : Array):
	
	visible = true
	for child : Node in vbox.get_children():
		child.queue_free()
	
	for action : EditorAction in actions:
		var button : Button = Button.new()
		button.text = action.get_name()
		button.mouse_entered.connect(
			func():
				print("HOVER:", button.text)
		)

		button.pressed.connect(_on_button_pressed.bind(action))
		vbox.add_child(button)
	
# ---------------------------------------------------------------------------

func hide() -> void:
	visible = false
	
# ---------------------------------------------------------------------------

func _on_button_pressed(action):
	print("button ", action, " pressed")
	action_selected.emit(action)
	visible = false

# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
