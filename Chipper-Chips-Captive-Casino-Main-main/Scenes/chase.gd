extends State
class_name goonChase

@onready var enemy = $"../.."

var lineOfSight: bool = false
var trackTime: int = 0

var delta: float


func enter():
	pass



func exit():
	pass

func physics_update():
	enemy.Nav_agent.set_target_position(enemy.player.global_position)

	var next_point = enemy.Nav_agent.get_next_path_position()

	var move_direction = next_point - enemy.global_position
	move_direction.y = 0

	if move_direction.length() < 0.1:
		return

	enemy.direction = move_direction.normalized()
	enemy.velocity = enemy.direction * enemy.speed
	enemy.look_at(enemy.player.global_position)

	enemy.rotation.x = 0
	enemy.rotation.z = 0
	if lineOfSight == false and Global.hiding == false:
		trackTime += 1
	else:
		trackTime = 0
	if trackTime > 400:
		$"..".set_state($"../Wander")

	var target_dist = enemy.player.global_position - enemy.global_position
	target_dist.y = 0
	
	if abs(target_dist.length()) < 1:
		get_tree().quit()
		
	enemy.move_and_slide()
