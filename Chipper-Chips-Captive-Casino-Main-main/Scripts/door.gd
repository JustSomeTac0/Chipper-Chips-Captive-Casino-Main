extends Node3D

var direction_opened = "closed"

enum DoorType{
	UNLOCKED,
	LOCKED,
	CHIPLOCKED
}
@export var door_type: DoorType = DoorType.UNLOCKED

enum DoorReq{
	TUT_KEY,
	STAFF_KEY,
	VIP_PASS,
}
@export var door_req: DoorReq = DoorReq.TUT_KEY
@export var door_cost: int

func open_left():
	if direction_opened == "closed":
		$CSGBox3D.rotation = Vector3(0, 300, 0)
		$CSGBox3D.position = Vector3(+0.8, +0, +0.8)
		$CSGBox3D/AudioStreamPlayer3D.play()
		direction_opened = "left"
		
func open_right():
	if direction_opened == "closed":
		$CSGBox3D.rotation = Vector3(0, 300, 0)
		$CSGBox3D.position = Vector3(+0.8, +0, -0.8)
		$CSGBox3D/AudioStreamPlayer3D.play()
		direction_opened = "left"


func _on_area_3d_body_entered(body: CharacterBody3D) -> void:
	match self.door_type:
		self.DoorType.UNLOCKED:
			open_left()
		self.DoorType.LOCKED:
			match self.door_req:
				self.DoorReq.TUT_KEY:
					if Global.tutorial_key == true:
						open_left()
				self.DoorReq.STAFF_KEY:
					if Global.staff_key == true:
						open_left()
				self.DoorReq.VIP_PASS:
					if Global.vip_pass == true:
						open_left()
		self.DoorType.CHIPLOCKED:
			if Global.chips > door_cost:
				open_left()



func _on_area_3d_2_body_entered(body: Node3D) -> void:
	match self.door_type:
		self.DoorType.UNLOCKED:
			open_right()
		self.DoorType.LOCKED:
			match self.door_req:
				self.DoorReq.TUT_KEY:
					if Global.tutorial_key == true:
						open_right()
				self.DoorReq.STAFF_KEY:
					if Global.staff_key == true:
						open_right()
				self.DoorReq.VIP_PASS:
					if Global.vip_pass == true:
						open_right()
		self.DoorType.CHIPLOCKED:
			if Global.chips > door_cost:
				open_left()



func _on_area_3d_3_body_exited(body: Node3D) -> void:
	if direction_opened != "closed":
		$CSGBox3D.rotation = Vector3(0, 0, 0)
		$CSGBox3D.position = Vector3(0, 0, 0)
		direction_opened = "closed"
