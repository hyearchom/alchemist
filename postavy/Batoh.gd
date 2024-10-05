extends Inventar

signal prisady_zmeneny
signal lektvary_zmeneny

var lektvary: Dictionary
var prisady: Dictionary


func _upozornit_na_zmenu(kontejner:Dictionary) -> void:
	var oznameni: Signal
	if kontejner.hash() == prisady.hash():
		oznameni = prisady_zmeneny
	elif kontejner.hash() == lektvary.hash():
		oznameni = lektvary_zmeneny
	oznameni.emit()
