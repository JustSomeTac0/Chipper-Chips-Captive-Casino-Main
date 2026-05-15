extends Node2D
var player 
var effectTimer
var effectProgressBar
var effectMaster

###change this if another effect
var Energized
var isEnergized = false
###

func _ready() -> void:
	player =  $"../../.."
	effectTimer = $"Effect Timer"
	effectProgressBar = $EffectProgressBar
	effectProgressBar.max_value = effectTimer.wait_time
	effectMaster = $".."
	###change this if another effect
	Energized = self
	###

###change this if another effect
func effectEnergizedActive():
	isEnergized = true
	player.regenTime = player.regenTime / 4
	effectTimer.start()
	effectMaster.handleEffects(Energized)
###


func _on_effect_timer_timeout() -> void:
	###change this if another effect
	player.regenTime = player.regenTime * 4
	isEnergized = false
	###
	
	
	effectMaster.effectList.pop_at(effectMaster.effectList.find(self))
	#cool animation#
	for i in range(10):
		self.position.x = self.position.x + 10
		await get_tree().create_timer(0.01).timeout
	

#func _input(event): #testing
	#if Input.is_action_pressed("devButton"):
		#effectEnergizedActive()
		


func _process(delta: float) -> void:
	###change this if another effect
	if isEnergized == true:
	###
		effectProgressBar.value = effectTimer.time_left
