class_name FirstPersonPlayerController
extends Node

signal move(direction: Vector3)
signal look(mouse_delta: Vector2)
signal jump
signal interact_signal

@export var mouse_sensitivity: float = 0.15

var is_mouse_free: bool = false
var _in_ui: bool = false
var _in_dialogue: bool = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)


func _physics_process(_delta: float) -> void:
	if _in_dialogue:
		return
	_process_movement_input()
	_process_jump_input()
	_process_interact_input()
	_process_menu_input()

func _input(event: InputEvent) -> void:
	if _in_dialogue:
		return

	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		look.emit(event.relative * mouse_sensitivity)

	# Release mouse with ESC - Used for debugging purposes. Might keep 
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


func _on_dialogue_started(_resource: DialogueResource) -> void:
	_in_dialogue = true
	move.emit(Vector3.ZERO)


func _on_dialogue_ended(_resource: DialogueResource) -> void:
	_in_dialogue = false


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
 

func _process_menu_input()->void:
	if Input.is_action_just_pressed("menu"):
		Events.menu_button_pressed()
		if is_mouse_free:
			is_mouse_free = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			is_mouse_free = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process_jump_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jump.emit()


func _process_interact_input() -> void:
	if Input.is_action_just_pressed("interact"):
		interact_signal.emit()
