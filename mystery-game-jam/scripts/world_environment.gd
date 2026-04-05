extends WorldEnvironment

const EVENING_SKY = preload("uid://vejmgkr2brbg")
const MORNING_SKY = preload("uid://qklncbr6xda5")
const NIGHT_SKY = preload("uid://b8qtmimskeq6s")
const NOON_SKY = preload("uid://cc6l5mhcyybtk")


func _ready() -> void:
	DayNightCycle.day_state_changed.connect(_on_day_state_changed)
	
	var current_state: int = DayNightCycle.get_current_day_state()
	_on_day_state_changed(current_state)


func _on_day_state_changed(state: int) -> void:
	match state:
		##TODO Create functions for each state to add Lighting and posible other shaders. 
		DayNightCycle.DayState.MORNING:
			
			environment.sky.sky_material = MORNING_SKY
			
		DayNightCycle.DayState.NOON:
			environment.sky.sky_material = NOON_SKY
			
		DayNightCycle.DayState.EVENING:
			environment.sky.sky_material = EVENING_SKY
			
		DayNightCycle.DayState.NIGHT:
			environment.sky.sky_material = NIGHT_SKY
