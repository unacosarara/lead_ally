extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 70
const speed = 20
var direccion: bool
@export var anim: AnimationPlayer 
@export var cast_player_left: RayCast2D
@export var cast_player_right: RayCast2D
@export var cast_left: RayCast2D
@export var cast_right: RayCast2D
@export var sprite: Sprite2D
var bullet: PackedScene = preload("res://lead/ecenas/bullet_1.tscn")

func _ready():
	anim.play("run")
	velocity.x = -SPEED
	
func _physics_process(delta):
	
	if cast_player_left.is_colliding():
		var bullet_instance = bullet.instantiate()
		get_parent().add_child(bullet_instance)
		bullet_instance.position = global_position
		bullet_instance.direccion = -1
		
		sprite.flip_h = false
		velocity.x = -speed
	elif cast_player_right.is_colliding():
		var bullet_instance = bullet.instantiate()
		get_parent().add_child(bullet_instance)

		bullet_instance.direccion = 1
		sprite.flip_h = true
		velocity.x = speed

	if not cast_player_left.is_colliding() and !sprite.flip_h:
		velocity.x = -SPEED
	elif not cast_player_right.is_colliding() and sprite.flip_h: 
		velocity.x = SPEED
		
	if cast_left.is_colliding():
		sprite.flip_h = true
	elif cast_right.is_colliding():
		sprite.flip_h = false
		
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


