extends Node2D


var SlotMachine
var LeverArea
var StartArea
var PullDownCollision
var LeverStartCollision
var Arm

var PullingDown = false
var InStartArea = false
var InLeverArea = false

var CollisionHeightUp
var CollisionHeightDown
var GapForEachFrame




func _ready() -> void:
	SlotMachine = $SlotMachine
	LeverArea = $SlotMachine/LeverArea
	StartArea = $SlotMachine/StartArea
	PullDownCollision = $SlotMachine/LeverArea/WaysDownCollision
	LeverStartCollision = $SlotMachine/StartArea/StartCollision
	Arm = $Arm
	
	CollisionHeightDown = SlotMachine.position.y + 42
	CollisionHeightUp = CollisionHeightDown - 276
	GapForEachFrame = (CollisionHeightDown - CollisionHeightUp) / 5 #<----- last number here is total frame number
	
# y = 125 on the top and 401 the bottom
# 276 diffrance 
# slot position is  359 so 42 diffrance 
# Slot position + 42



func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if Input.is_action_pressed("LeftClick"):
			Arm.play("grab")
			if InStartArea == true:
				PullingDown = true
		elif Input.is_action_just_released("LeftClick"):
			PullingDown = false
			Arm.play("wait")
		
		var MousesYVaule = get_global_mouse_position().y
		var MousesXVaule = get_global_mouse_position().x
		
		if PullingDown == true:
			
			
			if MousesYVaule >= CollisionHeightUp and MousesYVaule <= (CollisionHeightUp + GapForEachFrame):
				SlotMachine.frame = 0
			elif MousesYVaule >= (CollisionHeightUp + GapForEachFrame) and MousesYVaule <= (CollisionHeightUp + (GapForEachFrame * 2)) :
				SlotMachine.frame = 1
			elif MousesYVaule >= (CollisionHeightUp + (GapForEachFrame * 2)) and MousesYVaule <= (CollisionHeightUp + (GapForEachFrame * 3)) :
				SlotMachine.frame = 2
			elif MousesYVaule >= (CollisionHeightUp + (GapForEachFrame * 3)) and MousesYVaule <= (CollisionHeightUp + (GapForEachFrame * 4)) :
				SlotMachine.frame = 3
			elif MousesYVaule >= (CollisionHeightUp + (GapForEachFrame * 4)) and MousesYVaule <= CollisionHeightDown:
				SlotMachine.frame = 4
				SlotMachine.play("Spin")
			else:
				SlotMachine.frame = 0
		
		Arm.position.x = MousesXVaule
		Arm.position.y = MousesYVaule








func _on_start_area_mouse_entered() -> void:
	InStartArea = true

func _on_start_area_mouse_exited() -> void:
	InStartArea = false


func _on_lever_area_mouse_entered() -> void:
	InLeverArea = true


func _on_lever_area_mouse_exited() -> void:
	InLeverArea = false
	PullingDown = false
