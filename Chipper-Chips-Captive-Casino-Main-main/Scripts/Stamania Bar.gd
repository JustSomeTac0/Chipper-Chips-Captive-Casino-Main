extends TextureProgressBar

var player
var currentStamina 
var PosSlot1
var PosSlot2
var PosSlot3
var NegtiveSlot1
var NegtiveSlot2
var NegtiveSlot3
var startingYPostive
var startingYNegative
var moveDownAmountPos
var moveDownAmountBad

func _ready() -> void:
	player = $"../.." #play root
	player.staminaChanged.connect(update) #connecting
	self.value = self.max_value
	currentStamina = self.value
	PosSlot1 = $PostiveSlot1
	PosSlot2 = $"PostiveSlot2"
	PosSlot3 = $"PostiveSlot3"
	NegtiveSlot1 = $"NegativeSlot1"
	NegtiveSlot2 = $"NegativeSlot2"
	NegtiveSlot3 = $"NegativeSlot3"
	startingYPostive = PosSlot1.position.y
	startingYNegative = NegtiveSlot1.position.y
	moveDownAmountPos = (394.0 - startingYPostive) / (self.max_value/3)
	moveDownAmountBad = (260.0 - startingYNegative) / (self.max_value/3)
#570 y -----> 394.0


func update():
	self.value = player.stamina
	if currentStamina > self.value: #for when stamina is going down
		if self.value >= (self.max_value/3 + self.max_value/3):
			PosSlot3.position.y = PosSlot3.position.y + moveDownAmountPos
			NegtiveSlot3.position.y = NegtiveSlot3.position.y + moveDownAmountBad
		elif self.value >= (self.max_value/3):
			PosSlot2.position.y = PosSlot2.position.y + moveDownAmountPos
			NegtiveSlot2.position.y = NegtiveSlot2.position.y + moveDownAmountBad
		else:
			PosSlot1.position.y = PosSlot1.position.y + moveDownAmountPos
			NegtiveSlot1.position.y = NegtiveSlot1.position.y + moveDownAmountBad
			
			
			
	elif currentStamina < self.value: #for when stamina is going up
		if self.value >= (self.max_value/3 + self.max_value/3 + 1):
			PosSlot3.position.y = PosSlot3.position.y - moveDownAmountPos
			NegtiveSlot3.position.y = NegtiveSlot3.position.y - moveDownAmountBad
		elif self.value >= (self.max_value/3 + 1):
			PosSlot2.position.y = PosSlot2.position.y - moveDownAmountPos
			NegtiveSlot2.position.y = NegtiveSlot2.position.y - moveDownAmountBad
		else:
			PosSlot1.position.y = PosSlot1.position.y - moveDownAmountPos
			NegtiveSlot1.position.y = NegtiveSlot1.position.y - moveDownAmountBad
	
	currentStamina = self.value
	
