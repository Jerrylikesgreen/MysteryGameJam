## Autoloads - Globals

extends Node


var _underwater: bool = false

var _day: int = 1

func get_current_day()->int:
	return _day

func is_underwater()->bool:
	
	return _underwater

func set_underwater(v: bool) ->void:
	_underwater = v

func _day_transition()->void:
	_day += 1
	
