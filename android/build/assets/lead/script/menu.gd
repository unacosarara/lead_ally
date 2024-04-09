extends Control
@export var animation: AnimationPlayer


func _ready():
	animation.play("planeta")
	
func _on_historia_pressed():
	get_tree().change_scene_to_file("res://lead/ecenas/stage.tscn")


