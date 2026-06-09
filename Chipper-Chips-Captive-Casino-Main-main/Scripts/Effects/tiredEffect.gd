extends Node2D
var player 
var effectTimer
var effectProgressBar
var effectMaster

###change this if another effect
var Tired
var isTired = false
###

signal RunEffect

func _ready() -> void:
	player =  $"../../.."
	effectTimer = $"Effect Timer"
	effectProgressBar = $EffectProgressBar
	effectProgressBar.max_value = effectTimer.wait_time
	effectMaster = $".."
	self.RunEffect.connect(effectTiredActive)
	###change this if another effect
	Tired = self
	###

###change this if another effect
func effectTiredActive():
	isTired = true
	player.regenTime = player.regenTime * 4
	effectTimer.start()
	effectMaster.handleEffects(Tired)
###


func _on_effect_timer_timeout() -> void:
	###change this if another effect
	player.regenTime = player.regenTime / 4
	isTired = false
	###
	
	
	effectMaster.effectList.pop_at(effectMaster.effectList.find(self))
	#cool animation#
	for i in range(10):
		self.position.x = self.position.x + 10
		await get_tree().create_timer(0.01).timeout
	

func _input(event): #testing
	if Input.is_action_pressed("devButton"):
		effectTiredActive()
		


func _process(delta: float) -> void:
	###change this if another effect
	if isTired == true:
	###
		effectProgressBar.value = effectTimer.time_left
