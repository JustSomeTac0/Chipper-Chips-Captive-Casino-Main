extends Node3D

var cam: Camera3D
var player: CharacterBody3D
var player_body: CollisionShape3D

var in_range: bool = false

func _ready():
	cam = get_tree().get_first_node_in_group("camera")
	player = get_tree().get_first_node_in_group("player")
	player_body = get_tree().get_first_node_in_group("player_body")
	
	
func _unhandled_input(event: InputEvent) -> void:
	if Global.hiding == false:
		if in_range == true:
			if cam.is_position_in_frustum($MeshInstance3D.global_position):
				if Input.is_action_pressed("Interact"):
					$StaticBody3D.set_collision_layer_value(1, false)
					$StaticBody3D.set_collision_mask_value(1, false)
					$StaticBody3D.set_collision_layer_value(9, true)
					$StaticBody3D.set_collision_mask_value(9, true)
					player.position = $MeshInstance3D.global_position
					Global.hiding = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		in_range = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == player:
		in_range = false


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	pass # Replace with function body.
