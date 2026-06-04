extends InteractClass3D

var Collected = false
var ChipWorth = 100

var Hud
var ChipsHud 

func _ready() -> void:
	set_process_unhandled_input(false)
	
	Player = get_tree().get_first_node_in_group("player")
	Hud = Player.get_node("Hud")
	ChipsHud = Hud.get_node("ChipsAmountHUD")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		CollectChips()


func CollectChips():
	if Collected == false && PlayerInArea == true:
			Collected = true
			self.visible = false
			ChipsHud.ChangeChipAmount(ChipWorth, true)
