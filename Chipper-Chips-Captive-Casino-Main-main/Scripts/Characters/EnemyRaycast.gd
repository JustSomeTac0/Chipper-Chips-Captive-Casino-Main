extends RayCast3D

signal start_chase(who: String)

@export var enemy: String

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if player == null:
		return

	look_at(player.global_position)

	rotation.x = clamp(rotation.x, -0.75, 0.75)
	rotation.y = clamp(rotation.y, -0.75, 0.75)

	if is_colliding():
		var hit = get_collider()

		if hit and hit.name == "Player":
			start_chase.emit(enemy)
