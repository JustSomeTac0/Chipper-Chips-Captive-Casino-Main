extends Node2D


func _ready() -> void:
	pass 


func PlayButtonPressed() -> void:
	get_tree().change_scene_to_file("res://Chipper-Chips-Captive-Casino-Main-main/Scenes/Menus/loadingScreen.tscn")


func NotPlayButtonPressed() -> void:
	get_tree().quit()
