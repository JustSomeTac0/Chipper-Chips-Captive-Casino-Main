extends Sprite2D


var MyRichText
var PostiveAmountOfChips = true

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
	if PostiveAmountOfChips == true:
		if (Global.chips + numberToRound) >= 1000.00:
			numberToRound = (Global.chips + numberToRound) / 1000.00
			TextLetter = "K"
			numberToRound = snapped(numberToRound, 0.01)
		else:
			TextLetter = ""
			numberToRound = Global.chips + numberToRound
	
	
	elif PostiveAmountOfChips == false:
		if (Global.chips - numberToRound) >= 1000.00:
			numberToRound = (Global.chips - numberToRound) / 1000.00
			TextLetter = "K"
			numberToRound = snapped(numberToRound, 0.01)
		else:
			TextLetter = ""
			numberToRound = Global.chips - numberToRound
	
	
	
	
	Global.chips = CurrentChipAmount
	WriteToText(numberToRound)

func ChangeChipAmount(AmountToBeChanged, Increase):
	if Increase == true:
		CurrentChipAmount += AmountToBeChanged
	elif Increase == false:
		CurrentChipAmount = CurrentChipAmount - AmountToBeChanged
	else:
		CurrentChipAmount = CurrentChipAmount
		print("error")
	PostiveAmountOfChips = Increase
	RoundNumber(AmountToBeChanged)
