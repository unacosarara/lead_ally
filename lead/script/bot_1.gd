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
var shot: bool
var time: float = 1

func _ready():
	anim.play("run")
	velocity.x = -SPEED
	
func _physics_process(delta):
	
	if cast_player_left.is_colliding():
		sprite.flip_h = false
		velocity.x = -speed
		if shot:
			var bullet_instance = bullet.instantiate()
			get_parent().add_child(bullet_instance)
			bullet_instance.position = global_position
			bullet_instance.direccion = -1
			var bullet_sprite: Sprite2D = bullet_instance.get_node("Sprite2D")
			bullet_sprite.flip_h = true
			bullet_instance.anim.play("salir")
			shot = false
			time = 2

	elif cast_player_right.is_colliding():
		sprite.flip_h = true
		velocity.x = speed
		if shot:
			var bullet_instance = bullet.instantiate()
			get_parent().add_child(bullet_instance)
			bullet_instance.position = global_position
			bullet_instance.direccion = 1
			var bullet_sprite: Sprite2D = bullet_instance.get_node("Sprite2D")
			bullet_sprite.flip_h = false
			shot = false
			time = 2

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

func _process(delta):

	if !shot and time > 0:
		time -= delta
		if time < 1:
			shot= true
