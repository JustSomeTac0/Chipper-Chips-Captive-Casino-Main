extends StaticBody3D

var cam: Camera3D
var player: CharacterBody3D
var player_body: CollisionShape3D

var in_range: bool = false

enum Item{
	TUT_KEY,
	STAFF_KEY,
	VIP_PASS,
	SCREWDRIVER
}

@export var item: Item = Item.TUT_KEY

func _ready():
	cam = get_tree().get_first_node_in_group("camera")
	player = get_tree().get_first_node_in_group("player")
	player_body = get_tree().get_first_node_in_group("player_body")


func _physics_process(delta):
		if in_range == true:
			if cam.is_position_in_frustum($MeshInstance3D.global_position):
				if Input.is_action_pressed("Interact"):
					match self.item:
						self.Item.TUT_KEY:
							if Global.tutorial_key == false:
								Global.tutorial_key = true
						self.Item.STAFF_KEY:
							if Global.staff_key == false:
								Global.staff_key = true
						self.Item.VIP_PASS:
							if Global.vip_pass == false:
								Global.vip_pass = true
						self.Item.SCREWDRIVER:
							if Global.screwdriver == false:
								Global.screwdriver = true



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
