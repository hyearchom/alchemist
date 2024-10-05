extends Resource

signal novy_efekt

var status: Dictionary

func pusobeni(efekty: Dictionary) -> void:
	for nazev: String in efekty:
		zmena_efektu(nazev, efekty[nazev])


func zmena_efektu(nazev: StringName, kvantita: int) -> void:
	if status.has(nazev):
		_upravit_mnozstvi_efektu(nazev, kvantita)
	else:
		_vytvorit_efekt(nazev, kvantita)
	
	_upozornit_na_zmenu(nazev)


func _upravit_mnozstvi_efektu(nazev:StringName, kvantita:int) -> void:
	status[nazev] += kvantita
	
	# odstranění položky, pokud její počet klesne na nulu
	if status[nazev] == 0:
		status.erase(nazev)


func _vytvorit_efekt(nazev:StringName, kvantita:int) -> void:
	status[nazev] = kvantita


func _upozornit_na_zmenu(nazev:StringName) -> void:
	novy_efekt.emit(nazev)
