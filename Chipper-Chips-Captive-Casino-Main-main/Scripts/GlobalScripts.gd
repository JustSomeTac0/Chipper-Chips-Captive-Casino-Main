extends Sprite3D

#what stat stuff you have#
var PlayerLuck: int = 0

#what u be doin
var hiding: bool = false

#whatsa happening
var jackpot_time: bool = false
var power_out: bool = false

#what u gots
var tutorial_key: bool = false
var staff_key: bool = false
var vip_pass: bool = false
var screwdriver: bool =  false

var chips: int = 10000

#what le enemies be doin perchance
var dice_anger: int = 0



func PityPlayerLuckIncrease():
	if PlayerLuck < 26:
		PlayerLuck = PlayerLuck + 5
	elif 26 < PlayerLuck && PlayerLuck > 36:
		PlayerLuck = PlayerLuck + 3
	else:
		PlayerLuck = PlayerLuck + 1
	print(PlayerLuck)


func PlayerLuckDrain():
	if PlayerLuck < 5:
		PlayerLuck = PlayerLuck - PlayerLuck
	else:
		PlayerLuck = PlayerLuck - 5
	print(PlayerLuck)
