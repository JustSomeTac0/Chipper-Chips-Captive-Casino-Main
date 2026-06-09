extends Node2D
var player 
var effectTimer
var effectProgressBar
var effectMaster

###change this if another effect
var Fast
var isFast = false
###

signal RunEffect

func _ready() -> void:
	player =  $"../../.."
	effectTimer = $"Effect Timer"
	effectProgressBar = $EffectProgressBar
	effectProgressBar.max_value = effectTimer.wait_time
	effectMaster = $".."
	self.RunEffect.connect(effectFastActive)
	###change this if another effect
	Fast = self
	self._process(false)
	###

###change this if another effect
func effectFastActive(): #change this to player speed
	self._process(true)
	isFast = true
	player.SPEED = player.SPEED * 1.2
	effectTimer.start()
	effectMaster.handleEffects(Fast)
###


func _on_effect_timer_timeout() -> void:
	###change this if another effect
	player.SPEED = player.SPEED / 1.2
	isFast = false
	###
	
	
	effectMaster.effectList.pop_at(effectMaster.effectList.find(self))
	#cool animation#
	for i in range(10):
		self.position.x = self.position.x + 10
		await get_tree().create_timer(0.01).timeout
	
	self._process(false)
	


func _process(delta: float) -> void:
	###change this if another effect
	if isFast == true:
	###
		effectProgressBar.value = effectTimer.time_left
