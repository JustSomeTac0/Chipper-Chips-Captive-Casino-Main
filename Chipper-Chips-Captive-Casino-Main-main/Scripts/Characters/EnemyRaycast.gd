extends RayCast3D

signal start_chase(who: String)

@export var enemy: String

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	self.look_at(player.global_position) # this doesnt work at all rn but im too lazy to fix it
	if is_colliding():
		var hit = get_collider()
		if hit.name == "Player":
			start_chase.emit(enemy) # signal to goon1 to start chase
