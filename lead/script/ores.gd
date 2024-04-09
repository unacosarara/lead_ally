extends RigidBody2D

func _ready():
	var direx = Vector2(randf_range(-300, 300),randf_range(-100, -500))
	apply_central_impulse(direx)

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
