extends Sprite2D


var MyRichText


var CurrentChipAmount

var NormalTextEffect = "[wave]"
var TextLetter = ""


func _ready() -> void:
	MyRichText = $MyText
	
	CurrentChipAmount = Global.chips
	
	ChangeChipAmount(0, true)

func WriteToText(NumberToWrite):
	MyRichText.text = NormalTextEffect + str(NumberToWrite) + TextLetter

func RoundNumber(numberToRound):
	if (Global.chips + numberToRound) >= 1000:
		numberToRound = (Global.chips + numberToRound) / 1000.0
		TextLetter = "K"
	
	else:
		TextLetter = ""
	
	Global.chips = CurrentChipAmount
	WriteToText(numberToRound)

func ChangeChipAmount(AmountToBeChanged, Increase):
	if Increase == true:
		CurrentChipAmount += AmountToBeChanged
	elif Increase == false:
		CurrentChipAmount -= AmountToBeChanged
	else:
		CurrentChipAmount = CurrentChipAmount
	RoundNumber(AmountToBeChanged)
