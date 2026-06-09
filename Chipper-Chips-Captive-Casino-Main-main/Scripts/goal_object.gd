extends InteractClass3D



func _ready() -> void:
	TextLabel = $TextControl
	Player = get_tree().get_first_node_in_group("player")
	TextLabel.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		WinGame()



func WinGame():
	if Global.chips >= 3000:
		get_tree().change_scene_to_file("res://Chipper-Chips-Captive-Casino-Main-main/Scenes/Menus/WinScreen.tscn")
