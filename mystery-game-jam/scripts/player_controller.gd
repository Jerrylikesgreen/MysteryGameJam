class_name FirstPersonPlayerController
extends Node

signal move(direction: Vector3)
signal look(mouse_delta: Vector2)
signal jump
signal interact_signal

@export var mouse_sensitivity: float = 0.15

var is_mouse_free: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _physics_process(_delta: float) -> void:
	_process_movement_input()
	_process_jump_input()
	_process_interact_input()

func _input(event: InputEvent) -> void:

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		look.emit(event.relative * mouse_sensitivity)

	# Release mouse with ESC
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		is_mouse_free = true

	# Recapture mouse only if NOT clicking UI
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed \
	and is_mouse_free \
	and get_viewport().gui_get_hovered_control() == null:
		
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_mouse_free = false


func _process_movement_input() -> void:
	var input_dir := Vector3(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		0,
		Input.get_action_strength("backward") - Input.get_action_strength("forward")
	)

	if input_dir.length() > 0:
		move.emit(input_dir.normalized())
	else:
		move.emit(Vector3.ZERO)


func _process_jump_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jump.emit()


func _process_interact_input() -> void:
	if Input.is_action_just_pressed("interact"):
		interact_signal.emit()
