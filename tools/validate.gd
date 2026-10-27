# Run: godot --headless --path . --script res://tools/v.gd -- res://scripts/a.gd res://scenes/b.tscn
extends SceneTree

func _initialize() -> void:
	var bad := 0
	for path in OS.get_cmdline_user_args():
		if not _valid(path):
			bad += 1
			printerr("INVALID %s" % path)
	quit(1 if bad > 0 else 0)

func _valid(path: String) -> bool:
	var res := ResourceLoader.load(path)
	if res is GDScript:
		return (res as GDScript).can_instantiate() or (res as GDScript).is_abstract()
	if res is PackedScene:
		var scene := res as PackedScene
		if not scene.can_instantiate():
			return false
		var node := scene.instantiate()  # surfaces broken parent paths (as a WARNING)
		if node == null:
			return false
		node.free()
		return true
	return res != null
