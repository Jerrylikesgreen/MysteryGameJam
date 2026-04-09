class_name DialogueScreen extends CanvasLayer


@onready var speaker_name_lable: Label = %SpeakerNameLable
@onready var dialogue_text: RichTextLabel = %DialogueText


@export var type_speed: float = 0.01

var dialogue_running: bool = false


func _ready() -> void:
	Events.dialoge_text_signal.connect(_on_dialog_text_signal)


func _on_dialog_text_signal(speaker_name: String, dialoge: String) -> void:
	# Ignore signal if dialog is already running
	if dialogue_running:
		return

	dialogue_running = true
	visible = true
	
	speaker_name_lable.text = speaker_name
	dialogue_text.text = dialoge
	dialogue_text.visible_ratio = 0.0
	
	await _type_writer()
	
	await get_tree().create_timer(2.0).timeout
	
	visible = false
	dialogue_running = false


func _type_writer() -> void:
	while dialogue_text.visible_ratio < 1.0:
		dialogue_text.visible_ratio = min(dialogue_text.visible_ratio + type_speed, 1.0)
		await get_tree().process_frame
