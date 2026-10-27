# Godot 4 project: rules for Claude (lite)

Engine: **Godot 4.x, GDScript 2.0**. Never write Godot 3 syntax. Most tutorials online are Godot 3, so check every line against the table below.

## Do not read (token waste)
- `.godot/` (editor cache), `*.import`, `*.uid`: generated. Never read, grep, or edit them.
- Binary assets (`.png .wav .ogg .ttf .res .scn`) and `builds/`/`export/`: don't open them unless asked.
- Big `.tscn` files: `Grep` for `[node name=` instead of reading the whole file. Grep `project.godot` by section.

## Commands
- Run the main scene headless for ~2s: `godot --headless --path . --quit-after 120`
- Parse-check a script: `godot --headless --path . --check-only --script res://path.gd`
  - It **exits 0 even when there are parse errors** (Godot 4.7.2), so read the output for `SCRIPT ERROR`.
  - It can report false `Identifier not found` errors for autoloads. Confirm by running the scene.
- After adding a `class_name`: `godot --headless --path . --import`. Other scripts can't see the class until you do.

## GDScript 4: required forms
| Godot 3 (wrong) | Godot 4 (right) |
|---|---|
| `onready var x = $X` | `@onready var x: Sprite2D = $X` |
| `export var speed = 10` | `@export var speed: float = 10.0` |
| `tool` | `@tool` |
| `yield(obj, "sig")` | `await obj.sig` |
| `connect("hit", self, "_on_hit")` | `hit.connect(_on_hit)` |
| `emit_signal("hit", 3)` | `hit.emit(3)` |
| `var x setget set_x` | `var x: int:` + `set(value):` block |
| `KinematicBody2D`, `Spatial`, `Position2D` | `CharacterBody2D`, `Node3D`, `Marker2D` |
| `move_and_slide(vel, Vector2.UP)` | set `velocity`, then `move_and_slide()` |
| `scene.instance()` | `scene.instantiate()` |
| `change_scene(path)` | `change_scene_to_file(path)` |
| `PoolStringArray` | `PackedStringArray` |
| `deg2rad`, `rand_range` | `deg_to_rad`, `randf_range` |
| `.empty()` | `.is_empty()` |

## Style and signals
- Use static typing everywhere. Name signals in the past tense. Use `%UniqueName` for nodes that might move.
- Connect with callables: `button.pressed.connect(_on_pressed)`. Signals go up and calls go down.
- Don't connect in code something the `.tscn` already connects (`[connection signal=`). The handler would fire twice.

## Scenes (.tscn)
- Prefer editing `.gd`. In a `.tscn`, keep `format=3`. Every `ExtResource`/`SubResource` id must be declared. Never invent `uid://` values.

## How to work
- Touch only the files the task needs. No drive-by reformatting.
- Run everything with `--headless`. Never open the editor.
- Answer tersely. Summarize changes instead of echoing whole files.
