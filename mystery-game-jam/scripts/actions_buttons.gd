class_name ActionsButtons
extends Control

@onready var rock_button: Button = %RockButton
@onready var port_button: Button = %PortButton
@onready var village_button: Button = %VillageButton

@export var packed_scenes: Dictionary[Button, PackedScene]


func _ready() -> void:
	for button in packed_scenes.keys():
		button.pressed.connect(_on_button_pressed.bind(button))


func _on_button_pressed(button: Button) -> void:
	var scene: PackedScene = packed_scenes.get(button)
	print("pressed")
	
	if scene:
		Transition.change_scene(scene)
		
