class_name UnderwaterScene extends World


func _ready() -> void:
	Globals.set_underwater(true)
	call_deferred("_set_up")
