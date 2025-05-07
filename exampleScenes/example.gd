extends Node2D

@onready var _Player: CharacterBody2D = $Player
@onready var _Mark: Marker2D = $Marker2D

func _ready() -> void:
	_Player.global_position = _Mark.global_position
	pass


func _on_area_2d_3_body_entered(_body: Node2D) -> void:
	_Player.global_position = _Mark.global_position
	pass
