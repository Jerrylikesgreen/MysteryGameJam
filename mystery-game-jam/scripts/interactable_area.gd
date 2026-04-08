class_name PlayerInteractDetection extends Area3D


func interact() -> void:
	var areas = get_overlapping_areas()
	print(areas)
	

	for area in areas:
		if area is InteractionTrigger:
			area.activate()
