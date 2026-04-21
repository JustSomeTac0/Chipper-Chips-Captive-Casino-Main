extends TextureProgressBar

var player


func _ready() -> void:
	player = $"../../.." #play root
	player.staminaChanged.connect(update) #connecting


func update():
	if not player.stamina >= 100:#make sure no extra stamina
		self.value = player.stamina
