extends InteractClass3D


var SlotMachineGame

var MachineCost = 100
var WinAmount = 200

func _ready() -> void:
	SlotMachineGame = $SlotMachineGame
	TextLabel = $TextControl
	Player = get_tree().get_first_node_in_group("player")
	
	TextLabel.visible = false
	SlotMachineGame.visible = false
	SlotMachineGame.set_process_input(false)
	
	
	SlotMachineGame.TakeAwayChipsCost.connect(MachineCostFunc)
	SlotMachineGame.GameWon.connect(MachineWon)
	SlotMachineGame.GameLost.connect(MachineLost)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		
		if PlayerInArea == true:
		
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				SlotMachineGame.visible = false
				SlotMachineGame.set_process_input(false)
				Player.ProcessInputs = true
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				SlotMachineGame.visible = true
				SlotMachineGame.set_process_input(true)
				Player.ProcessInputs = false
				SlotMachineGame.ResetScene()


func MachineCostFunc():
	Player.gotChips(MachineCost, false)

func MachineWon():
	Player.gotChips(WinAmount, true)

func MachineLost():
	pass
