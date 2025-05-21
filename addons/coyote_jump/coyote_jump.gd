# Coyote Jump v1.0 - Godot Plugin created by Mariano Damian Abadie
# License: https://github.com/marianokpo/coyote_jump/blob/main/README.md
# Donations? → https://whydonate.com/es/donate/donaciones-por-proyectos
@tool
class_name CoyoteJump
extends Node


## Coyote Time and Jump Buffer Plugin for Godot 4.x ##
## Allows jumping shortly after leaving the ground and pre-buffered jumps ##

@export_category("Coyote Jump Settings")

@export_range(0.0, 0.5, 0.01, "suffix:s") var coyote_time: float = 0.2
@export_range(0.0, 0.5, 0.01, "suffix:s") var buffer_time: float = 0.15
@export var jump_action: StringName = &"ui_accept"

@export_category("Debug / Preview (Editor Only)")
@export var debug_print: bool = false

var _coyote_timer: float = 0.0
var _buffer_timer: float = 0.0
var _is_on_floor: bool = false
var _jump_requested: bool = false

func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

	# Coyote Timer
	if _is_on_floor:
		_coyote_timer = coyote_time
	else:
		_coyote_timer = max(_coyote_timer - delta, 0.0)

	# Buffer input
	if _buffer_timer > 0.0:
		_buffer_timer -= delta

	if Input.is_action_just_pressed(jump_action):
		_buffer_timer = buffer_time
		if debug_print:
			print("Jump input buffered")

	if can_jump():
		_jump_requested = true
		_buffer_timer = 0.0
		_coyote_timer = 0.0
		if debug_print:
			print("Jump triggered")

func set_on_floor(on_floor: bool) -> void:
	_is_on_floor = on_floor

func can_jump() -> bool:
	return _coyote_timer > 0.0 and _buffer_timer > 0.0

func consume_jump() -> bool:
	if _jump_requested:
		_jump_requested = false
		return true
	return false
