extends CharacterBody3D

@export var speed: float = 2.0
@export var chase_speed: float = 8.0
@export var current_node: Waypoint

#constants
var forgetfulness  = randf_range(-3, 3)
var thoroughness = randf_range(0.8, 1.2)
var laziness = randf_range(0.8, 1.2)
var attention_span = randf_range(0.8, 1.2)

var side_room_weight = thoroughness

var target_node: Waypoint
var previous_node: Waypoint
var waiting: bool = false


func _ready():
	global_transform.origin = current_node.global_transform.origin
	choose_next_node()
	print(forgetfulness)
	print(thoroughness)
	print(laziness)
	print(attention_span)
	
func _physics_process(delta):
	if waiting or target_node == null:
		velocity = Vector3.ZERO
		move_and_slide()
		return

	var to_target = target_node.global_position - global_position
	to_target.y = 0

	var distance = to_target.length()


	if distance < 0.4:
		arrive_at_node()
		return

	var direction = to_target / distance
	velocity = direction * speed

	move_and_slide()
	

func choose_next_node():
	var best_node: Waypoint = null
	var best_score := -1.0
	var options = current_node.connected_nodes
	
	if previous_node != null and previous_node in options and options.size() > 1:
		if randf_range(0 + forgetfulness, 100) > 90:
			print("turning around!")
			waiting = true
			await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
			waiting = false

			target_node = previous_node
			previous_node = current_node
			return

	var weight := 1.0
	for node in current_node.connected_nodes:
		if node == previous_node and options.size() > 1:
			continue
		match node.node_type:
			Waypoint.NodeType.NORMAL:
				weight = 1.0
			Waypoint.NodeType.SIDE_ROOM:
				weight = side_room_weight
			Waypoint.NodeType.VENT:
				weight = 0
			Waypoint.NodeType.TRAP_SETTING_SPOT:
				weight = 0

		var score = randf_range(0.1, 10) * weight

		if score > best_score:
			best_score = score
			best_node = node
	target_node = best_node
	previous_node = current_node
	
	
func arrive_at_node():
	previous_node = current_node
	current_node = target_node

	velocity = Vector3.ZERO

	if randf() < 0.2 * laziness:
		waiting = true
		await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
		waiting = false

	choose_next_node()
