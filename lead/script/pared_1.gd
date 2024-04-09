extends Node2D

var animplayer: AnimationPlayer 
var vida = 100

func _ready():
	$animpared_1.play("golpe")
	
func golpe(daño):
	print("yeckjdsa")
	vida -= daño
	$animpared_1.play("golpe")
	if vida < 0:
		$animpared_1.play("destroy")
			
func  destruir():
	queue_free()


