extends Node
class_name State

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

signal transitioned


func enter():
	pass


func exit():
	pass


func physics_update():
	pass


func transition_state(state: State, newState: State):
	if state != current_state:
		return
	if !newState:
		return
	if current_state:
		current_state.exit()
		newState.enter()
		current_state = newState


func set_state(newState: State):
	if newState != current_state:
		current_state = newState


func enter_state(newState: State):
	if newState != current_state:
		newState.enter()
		current_state = newState



func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(transition_state)
	if initial_state:
		initial_state.enter()
		current_state = initial_state



func _physics_process(float):
	if current_state:
		current_state.physics_update()
