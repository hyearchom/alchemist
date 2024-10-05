extends Node

@export var lexikon_prisad: Array[Resource]
@export var Batoh: Resource


func _ready() -> void:
	Batoh.prisady_zmeneny.connect(_sestavit_nabidku_prisad)
	_sestavit_nabidku_prisad()
	_overit_vybrane()


func _sestavit_nabidku_prisad() -> void:
	for nabidka:OptionButton in %Slozky.get_children():
		nabidka.clear()
		nabidka.add_item('---')
		for prisada:StringName in Batoh.prisady:
			nabidka.add_item(prisada)


func _pripravit_lektvar() -> void:
	var lektvar: Dictionary
	var vybrane_prisady: Array = _overit_vybrane()
	
	lektvar = {
		'efekt': {
			'leceni': 0,
			'odolnost': 0,
			'tiha': 0,
			},
		'barva': Color()
		}
	
	for prisada: Resource in vybrane_prisady:
		lektvar.efekt.leceni += prisada.leceni
		lektvar.efekt.odolnost += prisada.odolnost
		lektvar.efekt.tiha += prisada.tiha
	
	for hodnota: String in lektvar.efekt.keys():
		if lektvar.efekt[hodnota] == 0:
			lektvar.efekt.erase(hodnota)
	
	for prisada: Resource in vybrane_prisady:
		if not lektvar.barva:
			lektvar.barva = prisada.barva
		else:
			lektvar.barva = lektvar.barva.lerp(prisada.barva, 0.5)

	_znazornit_lektvar(lektvar)
	
	Batoh.zmena(
		_pojmenovat_lekvar(vybrane_prisady), 1, Batoh.lektvary, lektvar)


func _overit_vybrane() -> Array:
	var vybrane_prisady: Array
	for nabidka:OptionButton in %Slozky.get_children():
		var vybrane_cislo := nabidka.get_selected_id()
		if vybrane_cislo:
			var vybrany_nazev: String = nabidka.get_item_text(vybrane_cislo)
			for prisada: Resource in lexikon_prisad:
				if prisada.nazev == vybrany_nazev:
					if not prisada in vybrane_prisady:
						vybrane_prisady.append(prisada)
	vybrane_prisady.sort()
	return vybrane_prisady


func _znazornit_lektvar(lektvar:Dictionary) -> void:
	$Vytvor.show()
	%Barva.color = lektvar.barva
	%Efekt.text = 'Effect: ' + str(lektvar.efekt)
	await get_tree().create_timer(2.5).timeout
	$Vytvor.hide()


func _pojmenovat_lekvar(prisady:Array) -> StringName:
	var nazev: String = ''
	for prisada: Resource in prisady:
		nazev += prisada.nazev.left(3)
	nazev = nazev.capitalize()
	return nazev
	
