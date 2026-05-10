extends TextureProgressBar

var player


func _ready() -> void:
	player = $"../../.." #play root
	player.staminaChanged.connect(update) #connecting


func update():
	
	
	self.value = player.stamina
