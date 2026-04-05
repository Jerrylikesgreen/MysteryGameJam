class_name Player
extends Node3D

@onready var player_camera: Camera3D = %PlayerCamera
@onready var player_controller: FirstPersonPlayerController = %PlayerController
@onready var player_body: PlayerBody = %PlayerBody

@export var mouse_sensitivity: float = 0.1
@export var max_look_angle: float = 80.0
@onready var camera_pivot: Node3D = %CameraPivot

var _camera_rotation_x: float = 0.0
var _camera_rotation_y: float = 0.0

func _ready() -> void:
	# Initialize rotation variable from current pivot
	_camera_rotation_x = camera_pivot.rotation_degrees.x
	
	player_camera.current = true
	_connect_player_controller_signals()



func _connect_player_controller_signals()->void:
	player_controller.move.connect(_on_move)
	player_controller.look.connect(_on_look)
	player_controller.jump.connect(_on_jump)
	player_controller.interact_signal.connect(_on_interact)


func _on_move(direction: Vector3)->void:
	player_body.move(direction)




func _on_look(mouse_delta: Vector2) -> void:
	# Rotate Player Left / Right (Y axis)
	player_body.rotate_y(-mouse_delta.x * mouse_sensitivity * 0.02)

	# Rotate Camera Up / Down (X axis)
	_camera_rotation_x -= mouse_delta.y * mouse_sensitivity
	_camera_rotation_x = clamp(_camera_rotation_x, -max_look_angle, max_look_angle)

	camera_pivot.rotation_degrees.x = _camera_rotation_x
	print(_camera_rotation_x)

func _on_jump()->void:
	pass


func _on_interact()->void:
	pass
