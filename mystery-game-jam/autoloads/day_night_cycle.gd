## Autoload - DayNightCycle - will keep track of time of day 
extends Node

signal day_state_changed( d_state: DayState )

enum DayState { MORNING, NOON, EVENING, NIGHT }

var _current_day_state: DayState = DayState.MORNING


func progress_time(time_progressed: int) -> void:
	
	_current_day_state = (_current_day_state + time_progressed) % DayState.size()
	day_state_changed.emit(_current_day_state)

func set_day_state( day_state: DayState ) ->void:
	_current_day_state = day_state
	day_state_changed.emit(_current_day_state)

func get_current_day_state()-> DayState:
	return _current_day_state
