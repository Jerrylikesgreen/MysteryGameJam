## Autoload - Events
extends Node


signal dialoge_text_signal(speaker: String, dialoge: String )
signal menu_button_signal


func dialogue_text( speaker: String, dialoge: String )->void:
	dialoge_text_signal.emit(speaker, dialoge)


func menu_button_pressed()->void:
	menu_button_signal.emit()
