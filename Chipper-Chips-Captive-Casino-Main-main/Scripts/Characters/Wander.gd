extends State
class_name goonWander

@onready var enemy = $"../.."

var delta: float


func enter():
	enemy.choose_next_node()
	
func exit():
	pass

func physics_update():
	if enemy.waiting or enemy.target_node == null:
		enemy.velocity = Vector3.ZERO
		enemy.move_and_slide()
		return

	enemy.target_dist = enemy.target_node.global_position - enemy.global_position
	enemy.target_dist.y = 0

	if enemy.target_dist.length() < 0.4:
		enemy.arrive_at_node()
		return

	enemy.direction = enemy.target_dist / enemy.target_dist.length()
	enemy.velocity = enemy.direction * enemy.speed
	enemy.look_at(enemy.target_node.global_position)

	enemy.rotation.x = 0
	enemy.rotation.z = 0
	enemy.move_and_slide()
