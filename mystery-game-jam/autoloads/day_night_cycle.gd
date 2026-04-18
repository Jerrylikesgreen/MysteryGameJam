## Autoload - DayNightCycle - will keep track of time of day
extends Node

signal day_state_changed(d_state: DayState)

enum DayState { MORNING, NOON, EVENING, NIGHT }

var _current_day_state: DayState = DayState.MORNING


func progress_time(time_progressed: int) -> void:
	var previous_state := _current_day_state

	_current_day_state = (_current_day_state + time_progressed) % DayState.size()

	# Detect NIGHT -> MORNING transition
	if previous_state == DayState.NIGHT and _current_day_state == DayState.MORNING:
		_trigger_new_day()

	day_state_changed.emit(_current_day_state)


func set_day_state(day_state: DayState) -> void:
	var previous_state := _current_day_state

	_current_day_state = day_state

	# Detects  transition NIGHT -> MORNING
	if previous_state == DayState.NIGHT and _current_day_state == DayState.MORNING:
		_trigger_new_day()

	day_state_changed.emit(_current_day_state)


func get_current_day_state() -> DayState:
	return _current_day_state


# Called when a new day begins (NIGHT → MORNING)
func _trigger_new_day() -> void:
	Events.next_day()
