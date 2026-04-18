class_name MoonUi extends CanvasLayer

const DAY1MOONTEXTURE = preload("uid://qmbgvyp2vyqi")
const DAY2MOONTEXTURE = preload("uid://bey3irhc2vnt6")
const DAY3MOONTEXTURE = preload("uid://8nxucf660nh2")
const DAY4MOONTEXTURE = preload("uid://d0cqfavgy5tyq")
const DAY5MOONTEXTURE = preload("uid://bod6tf4eqf5b3")
const DAY6MOONTEXTURE = preload("uid://ciyfmta5oeied")
const DAY7MOONTEXTURE = preload("uid://bv3odm8yqa35i")

@onready var moon_texture: TextureRect = %MoonTexture
@onready var day_label: Label = %DayLabel


func _ready() -> void:
	call_deferred("set_up")
	Events.new_day_signal.connect(set_up)


func set_up() -> void:
	var _day: int = Globals.get_current_day()

	_update_ui(_day)


func _update_ui(_day: int) -> void:
	day_label.text = "Day %d" % _day

	match _day:
		1:
			moon_texture.texture = DAY1MOONTEXTURE
		2:
			moon_texture.texture = DAY2MOONTEXTURE
		3:
			moon_texture.texture = DAY3MOONTEXTURE
		4:
			moon_texture.texture = DAY4MOONTEXTURE
		5:
			moon_texture.texture = DAY5MOONTEXTURE
		6:
			moon_texture.texture = DAY6MOONTEXTURE
		7:
			moon_texture.texture = DAY7MOONTEXTURE
