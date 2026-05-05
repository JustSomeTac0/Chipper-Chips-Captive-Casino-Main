extends CharacterBody3D

@export var speed: float = 4.0
@export var chase_speed: float = 8.0
@export var current_node: Waypoint

#constants
var forgetfulness  = randf_range(0.5, 1.5)
var thoroughness = randf_range(0.5, 1.5)
var laziness = randf_range(-2.5, 2.5)
var attention_span = randf_range(0.5, 1.5)

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

#defines how much they wanna go on the different path types
func weighted_pick(nodes: Array[Waypoint]) -> Waypoint:
	var total_weight = 0.0
	var weights = []

	for n in nodes:
		var w = 1.0

		match n.node_type:
			Waypoint.NodeType.SIDE_ROOM:
				w = thoroughness
			Waypoint.NodeType.NORMAL:
				w = 1.0
			Waypoint.NodeType.VENT:
				w = 0

		weights.append(w)
		total_weight += w

	var pick = randf() * total_weight
	var current = 0.0

	for i in range(nodes.size()):
		current += weights[i]
		if pick <= current:
			return nodes[i]

	return nodes[0]

func choose_next_node():
	var options = current_node.connected_nodes.duplicate()
	if randf_range(1,5) * forgetfulness > 4:
		target_node = previous_node
	else:
		target_node = weighted_pick(options)
	previous_node = current_node
	
	
func arrive_at_node():
	current_node = target_node

	velocity = Vector3.ZERO
	move_and_slide()


	if randf_range(1, 10) * laziness > 8:
		waiting = true
		await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
		waiting = false

	choose_next_node()
