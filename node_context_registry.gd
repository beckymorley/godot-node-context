extends RefCounted
class_name NodeContextRegistry

# ---------------------------------------------------------------------------

static var handlers := {}

# ---------------------------------------------------------------------------

static func discover_handlers(path: String):
	handlers.clear()
	var dir := DirAccess.open(path)

	if dir == null:
		return

	dir.list_dir_begin()

	while true:
		var file_name := dir.get_next()

		if file_name.is_empty():
			break

		if file_name.ends_with(".gd"):
			print("Load ", file_name)
			var script := load(path.path_join(file_name))
			print("Script: ", script)
			if script:
				var handler = script.new()
				print("handler: ", handler)

				if handler is NodeContextHandler:
					register(file_name, handler)

	dir.list_dir_end()

# ---------------------------------------------------------------------------


static func register(file_name : String, handler : NodeContextHandler):
	if handler and !handlers.has(file_name):
		handlers.get_or_add(file_name, {"handler" : handler, "actions": []})

# ---------------------------------------------------------------------------

static func get_handler(node):
	for file_name in handlers:
		if handlers[file_name]["handler"].can_handle(node):
			return handlers[file_name]["handler"]

	return null

# ---------------------------------------------------------------------------

static func get_actions(node) -> Array:
	var handler = get_handler(node)
	if handler:
		return handler.get_actions()

	return []

# ---------------------------------------------------------------------------
