# Godot 4 Agent Pack Lite (free, for Claude Code)

A small, honest `CLAUDE.md` for **Godot 4 / GDScript 2.0** projects. It does two things:

1. **Stops Godot 3 code.** Most GDScript online is Godot 3 (`onready`, `yield`, `KinematicBody2D`). The rules carry the 3→4 table so Claude writes Godot 4 the first time.
2. **Keeps junk out of context.** `.claude/settings.json` blocks reads of `.godot/` (editor cache), `*.import`, and `*.uid`. `.cursorignore` does the same for Cursor.

It's under 60 lines on purpose. Anthropic's docs recommend CLAUDE.md files under 200 lines, because longer files cost more context and get followed less.

## Install
Copy `CLAUDE.md`, `.claude/settings.json`, and `.cursorignore` into your project root, next to `project.godot`. If you already have a `CLAUDE.md`, merge by hand.

## Two Godot gotchas worth knowing (verified on 4.7.2)
- `godot --headless --check-only --script x.gd` **exits 0 even when it prints parse errors**. Don't let an agent trust the exit code.
- The same command can print false `Identifier not found: <YourAutoload>` errors for scripts that use autoloads.

## Free validator with a real exit code
`tools/validate.gd` loads each file and exits 1 if any is broken (0 if all are fine):

```bash
godot --headless --path . --import        # once, after adding a class_name
godot --headless --path . --script res://tools/validate.gd -- res://player.gd res://main.tscn
```

It won't catch calls to methods that don't exist on a typed object. GDScript only reports those at runtime, so you need tests for them.

## Want enforcement instead of hoping the rules are followed?
CLAUDE.md is context, not enforced configuration. The full pack adds:
- **Hooks** that *block* Godot 3 syntax and edits to generated files before they're written, and run a validator after every `.gd`/`.tscn` edit.
- **`tools/check.sh`**: a headless validator that gets the exit code right, handles autoloads and `class_name` caching, catches broken `.tscn` resource and parent paths, and prints only errors (fewer tokens).
- **A dependency-free headless test runner** plus `tools/test.sh`.
- **On-demand skills** (`.tscn` editing, Godot 3→4 porting, testing). They load only when needed instead of bloating every prompt.
- `/check` and `/port3` commands, a Cursor rule, an installer, and a sample project.

Full pack ($19, 30-day refund): https://bigchair.gumroad.com/l/zafkzc

License: MIT (see LICENSE). Built with AI assistance. Works with Claude Code and Cursor; not affiliated with or endorsed by Anthropic, Cursor, or the Godot Foundation.
