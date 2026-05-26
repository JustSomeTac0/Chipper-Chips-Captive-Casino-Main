extends Node2D
var effectList = []
var effect


#################all effects##############
#postive#
var Energized
var Fast
var Aware
var Lucky
var Tracking

#negative#
var Tired
var Slow
var Oblivious
var Unlucky
var Tracked
var Drunk

func _ready() -> void:
	Energized = $Energized
	Tired = $Tired
	Fast = $Fast
	Slow = $Slow
	Drunk = $Drunk


func handleEffects(effect): #just call the with the name of the effect like handleEffects(Energized)
	var moveAmount = 50
	print(effectList)
	if effect in effectList: #this is for when the effect is already active
		effect.effectTimer.start()
	else:
		effectList.push_back(effect) #put effect as the last item
		moveAmount = moveAmount * effectList.find(effect) #this is for y position
		effect.global_position.y = moveAmount
		for i in range(9): #cool popout
			effect.position.x = effect.position.x - 10
			await get_tree().create_timer(0.01).timeout
