extends CharacterBody2D
@export var direcion: float
const jump_limit = 1
@export var cant_jump = 0
const SPEED = 200
const jump_velocity = -350.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var animtrtee: AnimationTree
@export var hit: AnimationPlayer
@export var camara: Camera2D
var vida = 100

func _process(_delta):        
	$CanvasLayer/Control2/vida.value = vida
	
func _physics_process(delta): 

	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and jump_limit > cant_jump :
		velocity.y = jump_velocity
		cant_jump += 1
	if is_on_floor():
		cant_jump = 0
	var direction = Input.get_axis("ui_left", "ui_right")
	direcion = direction
	if Input.is_action_pressed("ui_left"):



		$sprite_sheet_yosef.position.x = -10.28
		$sprite_sheet_yosef.flip_h = true
	elif Input.is_action_pressed("ui_right"):
		$sprite_sheet_yosef.position.x = 0
		$sprite_sheet_yosef.flip_h = false
	if direction:
		if direction > 0 :
			camara.position.x = 30
		elif direction < 0 :
			camara.position.x = -100
		velocity.x = direction * SPEED
		animtrtee.set("parameters/conditions/is_run", true)
		animtrtee.set("parameters/conditions/is_idle", false) 
	else:
		animtrtee.set("parameters/conditions/is_run", false) 
		animtrtee.set("parameters/conditions/is_idle", true) 
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func daño_player(daño,dir):
	vida -= daño
	velocity.x += dir * 600
	hit.play("hit")
													   #<>



