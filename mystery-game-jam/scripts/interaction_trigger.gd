class_name InteractionTrigger extends Area3D


@export var speaker_name: String
@export var dialogue_file: String
@export var one_shot: bool  = false
@export var has_dialogue: bool = false
@export var is_step_trigger: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func activate()->void:
	if has_dialogue:
		trigger_dialogue()

func _on_body_entered( body: Node3D )->void:
	
	if body is PlayerBody and is_step_trigger:
		if is_step_trigger:
			step_trigger()
		
		if has_dialogue:
			trigger_dialogue()
			
		if one_shot:
			queue_free()


func step_trigger()->void:
	pass

func trigger_dialogue() -> void:
	var cue_key : String = speaker_name.to_lower() + "_dialogue_cue"
	var cue: String = State.get(cue_key)
	if cue == null:
		push_warning("InteractionTrigger: No State variable found for '%s'" % cue_key)
		return
	DialogueManager.show_example_dialogue_balloon(load(dialogue_file), cue)
