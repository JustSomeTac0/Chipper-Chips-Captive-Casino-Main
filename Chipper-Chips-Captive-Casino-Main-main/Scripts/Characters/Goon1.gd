extends CharacterBody3D

#speeds and start position#
@export var speed: float = 2.0
@export var chase_speed: float = 8.0
@export var current_node: Waypoint

#slight randomness to their prefrences in behavior#
var forgetfulness: float  = randf_range(-3, 3) #Amount of turning around
var thoroughness: float = randf_range(0.8, 1.2) #Likelyhood of checking side rooms
var laziness: float = randf_range(0.8, 1.2) #Amount of pausinng and length of pauses
var attention_span: float = randf_range(0.8, 1.2) #How long they stay in chase
var side_room_weight: float = thoroughness #side_room_weight is used so I can force them out of side rooms so they dont wander in circles forever 

@onready var player: CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var Nav_agent: NavigationAgent3D = $NavigationAgent3D

@onready var stateMachine = $StateMachine

var direction: Vector3
var target_dist: Vector3

#variables for wandering#
var target_node: Waypoint
var previous_node: Waypoint
var waiting: bool = false

#variables for chasing#
var in_chase: bool = false


@warning_ignore("untyped_declaration")
func _ready():
	stateMachine.enter_state($StateMachine/Wander)
	global_transform.origin = current_node.global_transform.origin
	choose_next_node()




@warning_ignore("untyped_declaration")
func choose_next_node():
	var best_node: Waypoint = null
	var best_score := -1.0
	var options: Array = current_node.connected_nodes
	
	if previous_node != null and previous_node in options and options.size() > 1:
		if randf_range(0 + forgetfulness, 100) > 90:
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

		var score: float = randf_range(0.1, 10) * weight

		if score > best_score:
			best_score = score
			best_node = node
	target_node = best_node
	previous_node = current_node
	
	
@warning_ignore("untyped_declaration")
func arrive_at_node():
	print("boop")
	previous_node = current_node
	current_node = target_node

	velocity = Vector3.ZERO
	match current_node.pause_rate:
		Waypoint.PauseRate.NORMAL:
			if randf() < 0.2 * laziness:
				waiting = true
				await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
				waiting = false
		Waypoint.PauseRate.LOW:
			if randf() < 0.1 * laziness:
				waiting = true
				await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
				waiting = false
		Waypoint.PauseRate.HIGH:
			if randf() < 0.3 * laziness:
				waiting = true
				await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
				waiting = false
		Waypoint.PauseRate.NEVER:
			pass
		Waypoint.PauseRate.ALWAYS:
			waiting = true
			await get_tree().create_timer(randf_range(0.5, 2.0) * laziness).timeout
			waiting = false

	choose_next_node()


func _on_ray_cast_3d_start_chase(who: Variant) -> void:
	if Global.hiding == false:
		if who == "Goon1":
			stateMachine.enter_state($StateMachine/Chase)
		
