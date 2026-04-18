class_name World extends Node3D




func _ready() -> void:
	call_deferred("_set_up")
	Globals.set_underwater(false)

func _set_up()->void:
	
	if Globals.is_underwater():
		ProjectSettings.set_setting("physics/3d/default_gravity", 3.0)
	
	else:
		
		ProjectSettings.set_setting("physics/3d/default_gravity", 9.6)
	
