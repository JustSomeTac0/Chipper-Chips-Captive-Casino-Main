extends Node2D


var SlotMachine
var LeverArea
var StartArea
var PullDownCollision
var LeverStartCollision

var PullingDown = false
var InStartArea = false
var InLeverArea = false

var CollisionHeightUp
var CollisionHeightDown


func _ready() -> void:
	SlotMachine = $SlotMachine
	LeverArea = $SlotMachine/LeverArea
	StartArea = $SlotMachine/StartArea
	PullDownCollision = $SlotMachine/LeverArea/WaysDownCollision
	LeverStartCollision = $SlotMachine/StartArea/StartCollision
	
	
	CollisionHeightDown = SlotMachine.position.y + 42
	CollisionHeightUp = CollisionHeightDown - 276

# y = 125 on the top and 401 the bottom
# 276 diffrance 
# slot position is  359 so 42 diffrance 
# Slot position + 42



func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if Input.is_action_pressed("LeftClick"):
			if InStartArea == true:
				PullingDown = true
		elif Input.is_action_just_released("LeftClick"):
			PullingDown = false
		
		
		
		








func _on_start_area_mouse_entered() -> void:
	InStartArea = true

func _on_start_area_mouse_exited() -> void:
	InStartArea = false


func _on_lever_area_mouse_entered() -> void:
	InLeverArea = true


func _on_lever_area_mouse_exited() -> void:
	InLeverArea = false
