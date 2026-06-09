extends InteractClass3D

var HUD
var EffectsParent

var Energized
var Fast
var Slow
var Tired
var Drunk

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
	
	ChooseGoodEffectList = [Energized, Fast]
	ChooseBadEffectList = [Slow, Tired, Drunk]
	
	print(EffectsParent)
	TextLabel.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InteractInputAction):
		UseMachine()



func UseMachine():
	if Global.chips >= 75:
		MySprite.frame = 0
		Player.gotChips(75, false)
		
		randomize()
		
		var RandomNumberCool = RNG.randi_range(1, 100)
		if RandomNumberCool <= 50 + Global.PlayerLuck:
			await GlobalEffects.SpriteShakeEffect(MySprite, 2)
			var ListLegnth = ChooseGoodEffectList.size()
			var AnotherRandomNumber = RNG.randi_range(0, ListLegnth - 1)
			var EffectChoosen = ChooseGoodEffectList[AnotherRandomNumber]
			EffectChoosen.RunEffect.emit()
			MySprite.frame = 1
		else:
			await GlobalEffects.SpriteShakeEffect(MySprite, 2)
			var ListLegnth = ChooseBadEffectList.size()
			var AnotherRandomNumber = RNG.randi_range(0, ListLegnth - 1)
			var EffectChoosen = ChooseBadEffectList[AnotherRandomNumber]
			EffectChoosen.RunEffect.emit()
			MySprite.frame = 2
		
		await get_tree().create_timer(0.9).timeout
		MySprite.frame = 0



func OnInteractionAreaEntered(body: Node3D) -> void:
	if body == Player:
		PlayerInArea = true
		TextLabel.visible = true
		set_process_unhandled_input(true)
		InteractionAvailable.emit()


func OnInteractionAreaExited(body: Node3D) -> void:
	if body == Player:
		PlayerInArea = false
		TextLabel.visible = false
		set_process_unhandled_input(false)
		InteractionUnavailable.emit()
