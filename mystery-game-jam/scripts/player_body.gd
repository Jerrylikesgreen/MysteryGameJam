class_name PlayerBody
extends CharacterBody3D

@export var speed: float = 10.0
@export var underwater_speed: float = 4.0

@export var jump_velocity: float = 5.0
@export var swim_up_force: float = 6.0

var _move_input: Vector3 = Vector3.ZERO
var _is_under_water: bool = false

var _gravity: float = 9.8
var _underwater_gravity: float = 3.0

var water_drag: float = 0.92


func _ready() -> void:
	call_deferred("_check_underwater")


func _check_underwater() -> void:
	if Globals.is_underwater():
		_is_under_water = true
		print("under water")
	else:
		print("not under water")


func _physics_process(delta: float) -> void:
	
	if _is_under_water:
		_underwater_physics(delta)
	else:
		_regular_physics(delta)

	# Apply gravity
	if not is_on_floor():
		if _is_under_water:
			velocity.y -= _underwater_gravity * delta
		else:
			velocity.y -= _gravity * delta
	else:
		if not _is_under_water:
			velocity.y = 0

	# Convert input to world space
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var move_dir = (forward * _move_input.z) + (right * _move_input.x)
	move_dir = move_dir.normalized() if move_dir.length() > 0 else Vector3.ZERO

	# Apply horizontal movement
	var current_speed = underwater_speed if _is_under_water else speed
	
	velocity.x = move_dir.x * current_speed
	velocity.z = move_dir.z * current_speed

	move_and_slide()


func _underwater_physics(delta: float) -> void:
	# Apply water drag
	velocity *= water_drag

	# Swim upward
	if Input.is_action_pressed("jump"):
		velocity.y += swim_up_force * delta


func _regular_physics(delta: float) -> void:
	# Regular jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity


func move(direction: Vector3) -> void:
	_move_input = direction


func jump() -> void:
	if _is_under_water:
		velocity.y += swim_up_force
	elif is_on_floor():
		velocity.y = jump_velocity


func set_underwater(state: bool) -> void:
	_is_under_water = state
