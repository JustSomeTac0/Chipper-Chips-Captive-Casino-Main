extends InteractClass3D

var HUD
var EffectsParent

var Energized
var Fast
var Slow
var Tired
var Drunk
var Lucky
var Unlucky

var ChooseGoodEffectList = []
var ChooseBadEffectList = []

var RNG = RandomNumberGenerator.new()
var MySprite

func _ready() -> void:
	TextLabel = $TextControl
	Player = get_tree().get_first_node_in_group("player")
	EffectsParent = %Player/Hud/Effects
	MySprite = $Sprite
	
	Energized = %Player/Hud/Effects/Energized
	Fast = %Player/Hud/Effects/Fast
	Slow = %Player/Hud/Effects/Slow
	Tired = %Player/Hud/Effects/Tired
	Drunk = %Player/Hud/Effects/Drunk
	Lucky = %Player/Hud/Effects/Lucky
	Unlucky = %Player/Hud/Effects/Unlucky
	
	ChooseGoodEffectList = [Energized, Fast, Lucky]
	ChooseBadEffectList = [Slow, Tired, Drunk, Unlucky]
	
	TextLabel.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction) && PlayerInArea == true:
		UseMachine()



func UseMachine():
	if Global.chips >= 75:
		MySprite.frame = 0
		Player.gotChips(75, false)
		
		randomize()
		
		$AudioStreamPlayer3D.stream = load("res://Chipper-Chips-Captive-Casino-Main-main/Sounds/gmod Ragdoll.wav")
		$AudioStreamPlayer3D.play()
		var RandomNumberCool = RNG.randi_range(1, 100)
		var EffectChoosen
		if RandomNumberCool <= 50 + Global.PlayerLuck: ##good effect
			await GlobalEffects.SpriteShakeEffect(MySprite, 2)
			var ListLegnth = ChooseGoodEffectList.size()
			var AnotherRandomNumber = RNG.randi_range(0, ListLegnth - 1)
			EffectChoosen = ChooseGoodEffectList[AnotherRandomNumber]
			MySprite.frame = 1
			Global.PlayerLuckDrain()
		else: #bad effect
			await GlobalEffects.SpriteShakeEffect(MySprite, 2)
			var ListLegnth = ChooseBadEffectList.size()
			var AnotherRandomNumber = RNG.randi_range(0, ListLegnth - 1)
			EffectChoosen = ChooseBadEffectList[AnotherRandomNumber]
			MySprite.frame = 2
			Global.PityPlayerLuckIncrease()
		
		$AudioStreamPlayer3D.stream = load("res://Chipper-Chips-Captive-Casino-Main-main/Sounds/Microwave DIng.wav")
		$AudioStreamPlayer3D.play()
		await get_tree().create_timer(0.9).timeout
		MySprite.frame = 0
		EffectChoosen.RunEffect.emit()
		$AudioStreamPlayer3D.stream = load("res://Chipper-Chips-Captive-Casino-Main-main/Sounds/killpop.wav")
		$AudioStreamPlayer3D.play()
