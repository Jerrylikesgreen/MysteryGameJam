extends Label

var _day_state_to_string: Dictionary = {
	DayNightCycle.DayState.MORNING : "Morning",
	DayNightCycle.DayState.NOON : "Noon",
	DayNightCycle.DayState.EVENING : "Evening",
	DayNightCycle.DayState.NIGHT : "Night",
}

func _ready() -> void:
	DayNightCycle.day_state_changed.connect(_on_day_state_changed)
	
	var _initial_day_state: String = _day_state_to_string[
		DayNightCycle.get_current_day_state()
	]
	
	text = _initial_day_state


func _on_day_state_changed(state: int) -> void:
	text = _day_state_to_string[state]
