## Autoload - Events
extends Node


signal dialoge_text_signal(speaker: String, dialoge: String )
signal menu_button_signal
signal new_day_signal

func dialogue_text( speaker: String, dialoge: String )->void:
	dialoge_text_signal.emit(speaker, dialoge)


func menu_button_pressed()->void:
	menu_button_signal.emit()

func next_day()->void:
	Globals._day_transition()
	new_day_signal.emit()
