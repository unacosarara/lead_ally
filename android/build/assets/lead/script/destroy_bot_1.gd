extends Node2D


func activar_particle():
	$CPUParticles2D.emitting = true
	$CPUParticles2D2.emitting = true

func eliminar():
	queue_free()
