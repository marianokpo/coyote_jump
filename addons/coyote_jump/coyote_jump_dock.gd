# Coyote Jump v1.0 - Plugin para Godot creado por Mariano Damian Abadie
# Licencia: https://github.com/[tu_usuario]/coyote-jump/blob/main/LICENSE.md
# ¿Donar? → https://whydonate.com/es/donate/donaciones-por-proyectos
@tool
extends Panel

var selected_node: Node = null

@onready var coyote_spin: SpinBox = $MarginContainer/VBoxContainer/HBoxCoyoteTime/CoyoteTimeSpin
@onready var buffer_spin: SpinBox = $MarginContainer/VBoxContainer/HBoxJumpBuffer/JumpBufferSpin
@onready var jump_action_input: LineEdit = $MarginContainer/VBoxContainer/HBoxJumpAction/JumpActionEdit

func _ready():
	set_process(true)

func _process(_delta):
	if not Engine.is_editor_hint():
		return

	if selected_node and selected_node is CoyoteJump:
		coyote_spin.value = selected_node.coyote_time
		buffer_spin.value = selected_node.buffer_time
		jump_action_input.text = selected_node.jump_action

func _on_coyote_time_changed(value):
	if selected_node:
		selected_node.coyote_time = value

func _on_buffer_time_changed(value):
	if selected_node:
		selected_node.buffer_time = value

func _on_jump_action_changed(new_text):
	if selected_node:
		selected_node.jump_action = new_text
