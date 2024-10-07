extends Resource

signal novy_efekt

var status: Dictionary

func pusobeni(efekty: Dictionary, trvani: float) -> void:
	for nazev: String in efekty:
		_zmena_efektu(nazev, efekty[nazev], trvani)


func _zmena_efektu(nazev: StringName, kvantita: int, trvani: float) -> void:
	if status.has(nazev):
		_upravit_mnozstvi_efektu(nazev, kvantita)
	else:
		_vytvorit_efekt(nazev, kvantita)
	
	_upozornit_na_zmenu(nazev, trvani)


func _upravit_mnozstvi_efektu(nazev:StringName, kvantita:int) -> void:
	status[nazev] += kvantita
	
	# odstranění položky, pokud její počet klesne na nulu
	if status[nazev] == 0:
		status.erase(nazev)


func _vytvorit_efekt(nazev:StringName, kvantita:int) -> void:
	status[nazev] = kvantita


func _upozornit_na_zmenu(nazev:StringName, trvani: float) -> void:
	novy_efekt.emit(nazev, trvani)


func ukoncit_efekt(nazev:StringName) -> void:
	status.erase(nazev)
