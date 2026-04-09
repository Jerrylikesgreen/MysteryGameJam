class_name ActionsMenu extends CanvasLayer



func _ready() -> void:
	Events.menu_button_signal.connect(_on_menu_button_signal)
	

func _on_menu_button_signal()->void:
	if is_visible():
		set_visible(false)
	else:
		set_visible(true)
