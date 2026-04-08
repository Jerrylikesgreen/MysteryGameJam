class_name InteractionTrigger extends Area3D


@export var speaker_name: String
@export var dialogue: String
@export var one_shot: bool  = false
@export var has_dialogue: bool = false
@export var is_step_trigger: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func activate()->void:
	if has_dialogue:
		triger_dialoge()

func _on_body_entered( body: Node3D )->void:
	
	if body is PlayerBody and is_step_trigger:
		if is_step_trigger:
			step_trigger()
		
		if has_dialogue:
			triger_dialoge()
			
		if one_shot:
			queue_free()


func step_trigger()->void:
	pass

func triger_dialoge()->void:
	Events.dialogue_text(speaker_name, dialogue)
