extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 70
const speed = 20
var direccion: bool
@export var vida = 100
@export var anim: AnimationPlayer 
@export var cast_player_left: RayCast2D
@export var cast_player_right: RayCast2D
@export var cast_left: RayCast2D
@export var cast_right: RayCast2D
@export var sprite: Sprite2D
@export var particle_bot_1: CPUParticles2D
@export var particle_bot_2: CPUParticles2D
var post_dead: PackedScene = preload("res://lead/ecenas/post_dead.tscn")
var bullet: PackedScene = preload("res://lead/ecenas/bullet_1.tscn")
var shot: bool
var time: float = 1
var blend_particle_bot : float = -1

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
	if vida <= 0:
		morir()
	if !shot and time > 0:
		time -= delta
		if time < 1:
			shot= true


func daño_player(dir):
	if blend_particle_bot == -1:
		blend_particle_bot = 1
		particle_bot_1.global_position = global_position
		particle_bot_1.emitting = true
	elif blend_particle_bot == 1:
		blend_particle_bot = -1
		particle_bot_2.global_position = global_position
		particle_bot_2.emitting = true
	$AnimationPlayer2.play("resivir_golpe")
	position.x += dir * 20
	vida -= 10
	
func morir():

	var new_post_dead = post_dead.instantiate()
	new_post_dead.global_position = $Marker_bot.global_position
	get_tree().current_scene.add_child(new_post_dead)
	queue_free()
#		for i in  randf_range(2,6):
#			var Ore1 = ore1.instantiate()
#			Ore1.position = $"posicionore".global_position
#			get_tree().current_scene.add_child(Ore1)
#		for i in  randf_range(1,4):
#			var Ore2 = ore2.instantiate()
#			Ore2.position = $"posicionore".global_position
#			get_tree().current_scene.add_child(Ore2)
#		for i in  randf_range(0,2):
#			var Ore3 = ore3.instantiate()
#			Ore3.position = $"posicionore".global_position
#			get_tree().current_scene.add_child(Ore3)
