extends RayCast3D

signal start_chase(who)

@export var enemy: String

var player: CharacterBody3D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	self.look_at(player.global_position) # this doesnt work at all rn but im too lazy to fix it
	if is_colliding():
		var hit = get_collider()
		if hit.name == "player":
			start_chase.emit(enemy) # signal to goon1 to start chase
