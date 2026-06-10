extends State
class_name goonChase

@onready var enemy = $"../.."

var lineOfSight: bool = false
var knowsPlayerPos: bool = false
var isAttentionTiming: bool = false
var timerrefreshed: bool = false

var delta: float


func enter():
	if lineOfSight == true:
		knowsPlayerPos = true
		timerrefreshed = true
	elif lineOfSight == false and isAttentionTiming == false:
		isAttentionTiming = true
		timerrefreshed = false
		#timer thing i forget how
		if timerrefreshed == false:
			pass #exit chase
	
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
	enemy.move_and_slide()
