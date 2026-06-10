extends InteractClass3D

var Collected = false

var ChipWorth = 100
var ChipAmount = 1

var RNG = RandomNumberGenerator.new()

var ChipsHud 
var ChipSprite






# do random chip vaule between 1, 5, 10, 25, 100
# then have a random amount between 1, 2, or 3




func _ready() -> void:
	set_process_unhandled_input(false)
	
	ChipSprite = $ChipsSprite
	TextLabel = $TextControl
	Player = get_tree().get_first_node_in_group("player")
	
	TextLabel.visible = false
	
	RandomChipSetup()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		CollectChips()



func RandomChipSetup():
	randomize()
	
	var RandomNumberWorth = RNG.randi_range(1, 5)
	var RandomNumberAmount = RNG.randi_range(1, 3)
	var RandomNumberChipVisible = RNG.randi_range(6, 8)
	
	ChipAmount = RandomNumberAmount
	
	###Sprite and worth Setup#################3#####################
	if ChipAmount == 1:
		ChipSprite.play("Single")
	elif ChipAmount == 2:
		ChipSprite.play("Double")
	elif ChipAmount == 3:
		ChipSprite.play("Triple")
	else:
		ChipSprite.play("Single")
	
	
	
	
	if RandomNumberWorth == 1:
		ChipWorth = 1
	elif RandomNumberWorth == 2:
		ChipWorth = 5
	elif RandomNumberWorth == 3:
		ChipWorth = 10
	elif RandomNumberWorth == 4:
		ChipWorth = 25
	elif RandomNumberWorth == 5:
		ChipWorth = 100
	
	
	ChipSprite.frame = RandomNumberWorth - 1
	
	
	#####################desideing if it shows or not#########################
	if RandomNumberChipVisible == 6:
		Collected = true
		self.visible = false
	elif RandomNumberChipVisible <= 7:
		Collected = false
		self.visible = true
	else:
		Collected = false
		self.visible = true



func CollectChips():
	if Collected == false && PlayerInArea == true:
			var RandomPitch = RNG.randf_range(0.9,1.1)
			$AudioStreamPlayer3D.pitch_scale = RandomPitch
			$AudioStreamPlayer3D.play()
			Collected = true
			self.visible = false
			var GainThese = ChipWorth * ChipAmount
			Player.gotChips(GainThese, true)
			print("Player got %d" %ChipAmount + " %d" %ChipWorth + "$ Chips")
