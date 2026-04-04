class_name PlayerBody
extends CharacterBody3D

@export var speed: float = 10.0
@export var gravity: float = 9.8
@export var jump_velocity: float = 5.0

var _move_input: Vector3 = Vector3.ZERO


func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0

	# Convert input to world space
	var forward = global_transform.basis.z   
	var right = global_transform.basis.x
	var move_dir = (forward * _move_input.z) + (right * _move_input.x)
	move_dir = move_dir.normalized() if move_dir.length() > 0 else Vector3.ZERO

	# Apply horizontal movement
	velocity.x = move_dir.x * speed
	velocity.z = move_dir.z * speed

	# Move the player
	move_and_slide()


func move(direction: Vector3) -> void:
	_move_input = direction


func jump() -> void:
	if is_on_floor():
		velocity.y = jump_velocity
