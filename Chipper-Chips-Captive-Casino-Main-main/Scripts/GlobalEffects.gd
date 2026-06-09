extends Node

var RNG = RandomNumberGenerator.new()

func _ready() -> void:
	pass 

													#example on calling this 
func SpriteShakeEffect(WhatToEffect, HowLong: float): # put await GlobalEffects.SpriteShakeEffect(MySprite, 4) to call and wait for it to finsih 
	if WhatToEffect is Node3D: # or just GlobalEffects.SpriteShakeEffect(MySprite, 4) if just calling 
		var ReturnToThis = WhatToEffect.position
		var TimerAmount = 0.015
		var HowManyTimes = HowLong / TimerAmount
		for i in range(HowManyTimes):
			var random_offset = Vector3(RNG.randf_range(-0.05, 0.05), WhatToEffect.position.y, RNG.randf_range(-0.05, 0.05))
			WhatToEffect.position = random_offset
			await get_tree().create_timer(TimerAmount).timeout
		WhatToEffect.position = ReturnToThis
