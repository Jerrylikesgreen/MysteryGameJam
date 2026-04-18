class_name UnderWaterVisuals extends Node3D

@onready var bubble_particle_emitter: GPUParticles3D = %BubbleParticleEmitter

func set_up(v: bool)->void:
	
	set_visible(v)
	bubble_particle_emitter.set_emitting(v)
	
