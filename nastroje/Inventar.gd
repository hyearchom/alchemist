extends Resource
class_name Inventar


func zmena(nazev:StringName, kvantita:int, kontejner:Dictionary, 
		doplnujici_udaje:={}) -> void:
	if kontejner.has(nazev):
		_upravit_mnozstvi_polozky(nazev, kvantita, kontejner)
	else:
		if kvantita > 0:
			_vytvorit_polozku(nazev, kvantita, kontejner)
			if doplnujici_udaje:
				_pridat_podrobnosti_polozky(nazev, doplnujici_udaje, kontejner)
		elif kvantita < 0:
			# snaha o snížení nepřítomné položky
			push_error('Položka {0} není v inventáři'.format([nazev]))
	
	_upozornit_na_zmenu(kontejner)


func _upravit_mnozstvi_polozky(nazev:StringName, kvantita:int, 
		kontejner:Dictionary) -> void:
	kontejner[nazev]['pocet'] += kvantita
	
	# odstranění položky, pokud její počet klesne na nulu
	if kontejner[nazev]['pocet'] == 0:
		kontejner.erase(nazev)
		

func _vytvorit_polozku(nazev:StringName, kvantita:int, kontejner:Dictionary) \
		 -> void:
	kontejner[nazev] = {'pocet': kvantita}


func _pridat_podrobnosti_polozky(nazev:StringName, doplnujici_udaje: Dictionary, 
		kontejner:Dictionary) -> void:
	kontejner[nazev].merge(doplnujici_udaje)


func _upozornit_na_zmenu(_kontejner:Dictionary) -> void:
	pass
