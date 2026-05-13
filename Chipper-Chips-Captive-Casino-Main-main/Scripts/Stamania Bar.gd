extends TextureProgressBar

var player
var currentStamina 
var PosSlot1
var PosSlot2
var PosSlot3
var NegtiveSlot1
var NegtiveSlot2
var NegtiveSlot3

func _ready() -> void:
	player = $"../../.." #play root
	player.staminaChanged.connect(update) #connecting
	currentStamina = self.value
	PosSlot1 = $"../PostiveSlot1"
	PosSlot2 = $"../PostiveSlot2"
	PosSlot3 = $"../PostiveSlot3"
	NegtiveSlot1 = $"../NegativeSlot1"
	NegtiveSlot2 = $"../NegativeSlot2"
	NegtiveSlot3 = $"../NegativeSlot3"


#570 y -----> 686


func update():
	self.value = player.stamina
	if currentStamina > self.value: #for when stamina is going down
		if self.value >= (self.max_value/3 + self.max_value/3 + 1):
			PosSlot3.position.y = PosSlot3.position.y + 2.9
			NegtiveSlot3.position.y = NegtiveSlot3.position.y + 2.9
		elif self.value >= (self.max_value/3 + 1):
			PosSlot2.position.y = PosSlot2.position.y + 2.9
			NegtiveSlot2.position.y = NegtiveSlot2.position.y + 2.9
		else:
			PosSlot1.position.y = PosSlot1.position.y + 2.9
			NegtiveSlot1.position.y = NegtiveSlot1.position.y + 2.9
			
			
			
	elif currentStamina < self.value: #for when stamina is going up
		if self.value >= (self.max_value/3 + self.max_value/3):
			PosSlot3.position.y = PosSlot3.position.y - 2.9
			NegtiveSlot3.position.y = NegtiveSlot3.position.y - 2.9
		elif self.value >= (self.max_value/3):
			PosSlot2.position.y = PosSlot2.position.y - 2.9
			NegtiveSlot2.position.y = NegtiveSlot2.position.y - 2.9
		else:
			PosSlot1.position.y = PosSlot1.position.y - 2.9
			NegtiveSlot1.position.y = NegtiveSlot1.position.y - 2.9
	
	currentStamina = self.value
	
