extends Node2D
var player 
var effectTimer
var effectProgressBar
var effectMaster

###change this if another effect
var Slow
var isSlow = false
###

signal RunEffect

func _ready() -> void:
	player =  $"../../.."
	effectTimer = $"Effect Timer"
	effectProgressBar = $EffectProgressBar
	effectProgressBar.max_value = effectTimer.wait_time
	effectMaster = $".."
	self.RunEffect.connect(effectSlowActive)
	###change this if another effect
	Slow = self
	self._process(false)
	###

###change this if another effect
func effectSlowActive(): #change this to player speed
	self._process(true)
	isSlow = true
	player.SPEED = player.SPEED / 1.25
	effectTimer.start()
	effectMaster.handleEffects(Slow)
###


func _on_effect_timer_timeout() -> void:
	###change this if another effect
	player.SPEED = player.SPEED * 1.25
	isSlow = false
	###
	
	
	effectMaster.effectList.pop_at(effectMaster.effectList.find(self))
	#cool animation#
	for i in range(10):
		self.position.x = self.position.x + 10
		await get_tree().create_timer(0.01).timeout
	
	self._process(false)
	


func _process(delta: float) -> void:
	###change this if another effect
	if isSlow == true:
	###
		effectProgressBar.value = effectTimer.time_left
