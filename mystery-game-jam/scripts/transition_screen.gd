class_name TransitionScreen
extends CanvasLayer

@onready var transition_label: Label = %TransitionLabel
@onready var transition_player: AnimationPlayer = %TransitionPlayer


func _ready() -> void:
	print("TransitionScreen READY")
	print("TransitionScreen Visible:", visible)

	Transition.transition_in_signal.connect(_on_transition_in_signal)
	Transition.transition_out_signal.connect(_on_transition_out_signal)
	set_visible(true)
	transition_player.play("transition_out")


func _on_transition_in_signal(scene_name: String)->void:
	print("Transition IN signal received")
	print("Visible before:", visible)

	if !is_visible():
		set_visible(true)

	print("Visible after:", visible)

	transition_label.text = scene_name
	transition_player.play("transition_in")


func transition_in_ended()->void:
	print("Transition IN ended")
	Transition.trantision_in_ended()


func transition_out_ended()->void:
	print("Transition OUT ended")
	set_visible(false)


func _on_transition_out_signal(scene_name: String)->void:
	print("Transition OUT signal received")
	print("Visible before:", visible)

	set_visible(true)

	print("Visible after:", visible)

	transition_label.text = scene_name
	transition_player.play("transition_out")
