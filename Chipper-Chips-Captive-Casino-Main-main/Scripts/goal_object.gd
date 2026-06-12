extends InteractClass3D

var in_range: bool = false

func _ready() -> void:
	TextLabel = $TextControl
	Player = %Player
	print(Player)
	TextLabel.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		if in_range == true:
			WinGame()



func WinGame():
	if Global.chips >= 3000:
		get_tree().change_scene_to_file("res://Chipper-Chips-Captive-Casino-Main-main/Scenes/Menus/WinScreen.tscn")


func _on_interaction_area_body_exited(body: Node3D) -> void:
	if body == Player:
		in_range = false
		TextLabel.visible = false


func _on_interaction_area_body_entered(body: Node3D) -> void:
	if body == Player:
		in_range = true
		TextLabel.visible = true
