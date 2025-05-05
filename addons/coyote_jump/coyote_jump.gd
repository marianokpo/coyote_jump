# Coyote Jump v1.0 - Plugin para Godot creado por Mariano Damian Abadie
# Licencia: https://github.com/[tu_usuario]/coyote-jump/blob/main/LICENSE.md
# ¿Donar? → https://whydonate.com/es/donate/donaciones-por-proyectos
@tool
extends Node
class_name CoyoteJump

## Coyote Time y Jump Buffer Plugin para Godot 4.x ##
## Permite saltar después de abandonar el suelo y pre-buffer de salto ##

@export_category("Coyote Jump Settings")

@export_range(0.0, 0.5, 0.01, "suffix:s") var coyote_time: float = 0.2
@export_range(0.0, 0.5, 0.01, "suffix:s") var buffer_time: float = 0.15
@export var jump_action: StringName = &"ui_accept"

@export_category("Debug / Preview (solo Editor)")
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

	# Timer de Coyote
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
