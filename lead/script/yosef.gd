extends CharacterBody2D

@export_category("Player")

@export_group("ConfigPlayer")
@export var vida = 100
@export var SPEED = 200
@export var jump_velocity = -350.0
@export var jump_limit = 1 #limite de saltos
var cant_jump = 0 # registrar cantidad de saltos echos
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export_group("Componentes")
@export var camara: Camera2D
@export var hit: AnimationPlayer
@onready var state_machine = $AnimationTree

var blend_atack: float = -1



func _physics_process(delta): 

# aplicar grabedad en el aire
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and jump_limit > cant_jump:
		velocity.y = jump_velocity
		cant_jump += 1
	if is_on_floor():
		cant_jump = 0

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
		if direction > 0 :
			$daño_enemi/CollisionShape2D.position.x = 3
			$sprite_sheet_yosef.position.x = 0
			$sprite_sheet_yosef.flip_h = false
			camara.position.x = 30
		elif direction < 0 :
			$daño_enemi/CollisionShape2D.position.x = -30
			$sprite_sheet_yosef.position.x = -10.28
			$sprite_sheet_yosef.flip_h = true
			camara.position.x = -100
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	call_deferred("animaciones")

func animaciones():
	state_machine["parameters/conditions/is_run"] = velocity.x != 0 and is_on_floor()
	state_machine["parameters/conditions/is_idle"] = velocity == Vector2(0, 0)
	state_machine["parameters/conditions/is_jump"] = velocity.y < 0
	state_machine["parameters/conditions/is_abajo"] = velocity.y > 0


func _process(_delta):        
	$CanvasLayer/Control2/vida.value = vida
	#reset time atack



#boton de ataque
func _on_atack_pressed():
	if state_machine["parameters/conditions/is_atack"] == false:
		state_machine["parameters/atack/blend_position"] = blend_atack
		state_machine["parameters/conditions/is_atack"] = true

func detecte_atack():
	SPEED = 100
	if blend_atack == 1:
		blend_atack = -1
	elif blend_atack == -1:
		blend_atack = 1
	$"daño_enemi".monitoring = true
func desactivar_atack():
	SPEED = 200
	state_machine["parameters/conditions/is_atack"] = false
	$"daño_enemi".monitoring = false
	
	
	
func daño_player(daño,dir):
	vida -= daño
	velocity.x += dir * 600
	hit.play("hit")

func _on_daño_enemi_body_entered(body):
	if body.is_in_group("bot_1"):
		body.daño_player()
		hit.play("golpe")



