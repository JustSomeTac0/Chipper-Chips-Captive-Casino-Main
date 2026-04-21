extends TextureProgressBar

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = $"../../.."
	player.staminaChanged.connect(update)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if not player.stamina >= 100:
		self.value = player.stamina
