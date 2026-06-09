extends Node2D
var player 
var effectTimer
var effectProgressBar
var effectMaster
var MapMaterial
var MaterialRotation = 0.001
var MaterialRotationDirec = "x"


###change this if another effect
var Drunk
var isDrunk = false
###

signal RunEffect

func _ready() -> void:
	player =  $"../../.."
	effectTimer = $"Effect Timer"
	effectProgressBar = $EffectProgressBar
	effectProgressBar.max_value = effectTimer.wait_time
	effectMaster = $".."
	MapMaterial = $"../../../../Map/NavigationRegion3D/Storage".get_material()
	self.RunEffect.connect(effectDrunkActive)

	###change this if another effect
	Drunk = self
	self._process(false)
	###

###change this if another effect
func effectDrunkActive():
	self._process(true)
	isDrunk = true
	effectTimer.start()
	effectMaster.handleEffects(Drunk)
	drunkSpinEffect()
###

#makes the textures spin in a circle kinda
func drunkSpinEffect():
	while isDrunk:
		await get_tree().create_timer(1).timeout
		if MaterialRotation == 0.001:
			MaterialRotation = -0.001
		elif MaterialRotation == -0.001:
			MaterialRotation = 0.001
	
	


func _on_effect_timer_timeout() -> void:
	###change this if another effect
	isDrunk = false
	MapMaterial.uv1_offset.x = 10.0
	MapMaterial.uv1_offset.z = 10.0
	MapMaterial.uv1_offset.y = 10.0
	###
	
	
	effectMaster.effectList.pop_at(effectMaster.effectList.find(self))
	#cool animation#
	for i in range(10):
		self.position.x = self.position.x + 10
		await get_tree().create_timer(0.01).timeout
	
	self._process(false)



func _process(delta: float) -> void:
	###change this if another effect
	if isDrunk == true:
	###
		for x in range(10):
				MapMaterial.uv1_offset.x += MaterialRotation * delta * 300
				MapMaterial.uv1_offset.z += MaterialRotation * delta * 300
				MapMaterial.uv1_offset.y += MaterialRotation * delta * 300
		effectProgressBar.value = effectTimer.time_left
