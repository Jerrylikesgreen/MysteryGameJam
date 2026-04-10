## Autoload - Transition
extends Node

var _path_to_new_scene: String = ""
var _new_scene_name: String = ""
signal transition_in_signal(scene_name: String)
signal transition_out_signal(scene_name: String)

func change_scene(scene_path: String, scene_name: String) -> void:
	_path_to_new_scene = scene_path
	_new_scene_name = scene_name
	_transition_in(scene_name)
	


func _transition_in(scene_name: String)->void:
	transition_in_signal.emit(scene_name)


func trantision_in_ended()->void:
	get_tree().change_scene_to_file(_path_to_new_scene)
	await get_tree().process_frame
	_transition_out()


func _transition_out()->void:
	transition_out_signal.emit(_new_scene_name)
