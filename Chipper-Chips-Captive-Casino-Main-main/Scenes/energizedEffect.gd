extends Node2D
var player 
var effectTimer
var effectProgressBar
var isEnergized = false

func _ready() -> void:
	player =  $"../../.."
	effectTimer = $"Effect Timer"
	effectProgressBar = $EffectProgressBar
	effectProgressBar.max_value = effectTimer.wait_time
	


func effectEnergizedActive():
	isEnergized = true
	player.regenTime = player.regenTime / 4
	effectTimer.start()


func _on_effect_timer_timeout() -> void:
	player.regenTime = player.regenTime * 4
	isEnergized = false

func _input(event): #testing
	if Input.is_action_pressed("devButton"):
		effectEnergizedActive()


func _process(delta: float) -> void:
	if isEnergized == true:
		effectProgressBar.value = effectTimer.time_left
		print(player.regenTime)
