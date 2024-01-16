extends Node2D
@export var fondo_1 : ParallaxBackground
@export var fondo_2 : ParallaxBackground
@export var fondo_3 : ParallaxBackground



func _on_parte_1_screen_entered():
	fondo_1.visible = true
func _on_parte_1_screen_exited():
	fondo_1.visible = false
func _on_parte_2_screen_entered():
	fondo_2.visible = true
func _on_parte_2_screen_exited():
	fondo_2.visible = false
func _on_parte_3_screen_entered():
	fondo_3.visible = true
func _on_parte_3_screen_exited():
	fondo_3.visible = false




 






