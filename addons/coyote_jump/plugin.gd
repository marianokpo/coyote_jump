@tool
extends EditorPlugin

var inspector_script := preload("res://addons/coyote_jump/coyote_jump.gd")
var dock: Control

func _enter_tree():
	add_custom_type("CoyoteJump", "Node", inspector_script, preload("res://addons/coyote_jump/icon.svg"))
	_create_dock()

func _exit_tree():
	remove_custom_type("CoyoteJump")
	_remove_dock()

func _create_dock():
	dock = preload("res://addons/coyote_jump/coyote_jump_dock.tscn").instantiate()
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dock)
	dock.visible = true

func _remove_dock():
	if dock:
		remove_control_from_docks(dock)
		dock.queue_free()
		dock = null

func _handles(object):
	return object is CoyoteJump

func _edit(object):
	if object is CoyoteJump and dock:
		dock.selected_node = object
