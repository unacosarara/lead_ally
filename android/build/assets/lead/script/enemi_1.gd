extends CharacterBody2D
@export_category("enemi_fly")

@export_group("config")
@export var SPEED = 100
@export var distance_atack = 400
var distance_to_player
var patruya: bool
var blend_point = 1
var distance_translate_1
var distance_translate_2




func _physics_process(_delta):
	
	var player_position = get_node("/root/Node2D/yosef").global_position
	var direction_to_player = player_position - global_position
	distance_to_player = direction_to_player.length()
	
	if distance_to_player < distance_atack:
		patruya = true
		velocity = direction_to_player.normalized() * SPEED
	else:
		patruya = false
		
		
	if patruya == false:
		#position 1
		var position_1 = get_node("/root/Node2D/Position_1").global_position
		var direction_translate_1 = position_1 - global_position
		distance_translate_1 = direction_translate_1.length()
		if blend_point == 1:
			velocity = direction_translate_1.normalized() * SPEED
		if distance_translate_1 < 1:
			blend_point = 2
			
		# position 2
		var position_2 = get_node("/root/Node2D/Position_2").global_position
		var direction_translate_2 = position_2 - global_position
		distance_translate_2 = direction_translate_2.length()
		if blend_point == 2:
			velocity = direction_translate_2.normalized() * SPEED
		if distance_translate_2 < 1:
			blend_point = 1

	move_and_slide()
