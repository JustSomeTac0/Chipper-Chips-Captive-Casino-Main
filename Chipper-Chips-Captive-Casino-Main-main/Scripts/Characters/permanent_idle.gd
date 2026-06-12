extends State
class_name goonStay

@onready var enemy = $"../.."

var delta: float


func enter():
	enemy.choose_next_node()
	
func exit():
	pass

func physics_update():
	pass
