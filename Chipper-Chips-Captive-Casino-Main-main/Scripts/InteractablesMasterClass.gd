class_name InteractClass3D
extends Node

var Player
var PlayerInArea
var TextLabel

signal Interacted
signal InteractionAvailable
signal InteractionUnavailable

@export var InteractInputAction := "Interact"

func _ready() -> void:
	set_process_unhandled_input(false)
	TextLabel = $TextControl
	Player = get_tree().get_first_node_in_group("player")
	
	TextLabel.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		Interacted.emit()
		get_viewport().set_input_as_handled()

func textCoolEffect():
	for i in range(2):
		TextLabel.font_size += 1
		await get_tree().create_timer(0.04).timeout 
	for i in range(2):
		TextLabel.font_size -= 1
		await get_tree().create_timer(0.07).timeout 
	if PlayerInArea == true:
		textCoolEffect()

func OnInteractionAreaEntered(body: Node3D) -> void:
	if body == Player:
		textCoolEffect()
		PlayerInArea = true
		TextLabel.visible = true
		set_process_unhandled_input(true)
		InteractionAvailable.emit()


func OnInteractionAreaExited(body: Node3D) -> void:
	if body == Player:
		PlayerInArea = false
		TextLabel.visible = false
		set_process_unhandled_input(false)
		InteractionUnavailable.emit()
