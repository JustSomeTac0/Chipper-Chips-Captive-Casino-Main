extends Sprite2D


var MyRichText


var CurrentChipAmount

var NormalTextEffect = "[wave]"
var TextLetter = ""


func _ready() -> void:
	MyRichText = $MyText
	
	CurrentChipAmount = Global.chips
	
	RoundNumber(Global.chips)
	

func WriteToText(NumberToWrite):
	MyRichText.text = NormalTextEffect + str(NumberToWrite) + TextLetter

func RoundNumber(numberToRound):
	if numberToRound >= 1000:
		numberToRound = numberToRound / 1000.0
		TextLetter = "K"
	
	WriteToText(numberToRound)

func ChangeChipAmount(AmountToBeChanged, Increase):
	if Increase == false:
		CurrentChipAmount += AmountToBeChanged
	elif Increase == true:
		CurrentChipAmount -= AmountToBeChanged
	else:
		CurrentChipAmount = CurrentChipAmount
	Global.chips = CurrentChipAmount
	RoundNumber(AmountToBeChanged)
