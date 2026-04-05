extends HBoxContainer

@onready var next_day_state: Button = %NextDayState


func _ready() -> void:
	next_day_state.pressed.connect(_on_next_day_state_pressed)
	

func _on_next_day_state_pressed()->void:
	print("pressed")
	DayNightCycle.progress_time(1)
