extends CharacterBody2D
@export var anim: AnimationPlayer
@export var SPEED: float 
var direccion: float
#var direccion: bool
func _ready():
	anim.play("salir")
func _physics_process(delta):
	velocity.x += direccion *  SPEED * delta
	move_and_slide() 

	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		anim.play("destroy")
		body.daño_player(1)
	anim.play("destroy")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
	pass # Replace with function body.
