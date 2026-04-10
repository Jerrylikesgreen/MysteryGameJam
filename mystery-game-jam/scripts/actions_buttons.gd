class_name ActionsButtons
extends Control

@export var scene_path_dic: Dictionary[Button, Array] ## [scene_path, scene_name]


func _ready() -> void:
	for button in scene_path_dic.keys():
		button.pressed.connect(_on_button_pressed.bind(button))


func _on_button_pressed(button: Button) -> void:
	var data: Array = scene_path_dic.get(button)

	if data:
		var scene_path: String = data[0]
		var scene_name: String = data[1]

		Transition.change_scene(scene_path, scene_name)
