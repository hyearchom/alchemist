extends VBoxContainer

@export var batoh: Resource
@export var vlastnosti: Resource

func _ready() -> void:
	get_tree().call_group('tlacitka', 'hide')
	batoh.lektvary_zmeneny.connect(_sestavit_nabidku)


func _sestavit_nabidku() -> void:
	get_tree().call_group('tlacitka', 'hide')
	
	var poradi: int = 1
	for zaznam: String in batoh.lektvary:
		var cesta_tlacitko: String = '%Tlacitko_{0}'.format([poradi])
		var tlacitko: Node = get_node(cesta_tlacitko)
		var jmenovka: Node = get_node(cesta_tlacitko + '/Nazev')
		var barva: Node = get_node(cesta_tlacitko + '/Flakonek/Barva')
		
		tlacitko.show()
		tlacitko.nazev = zaznam
		tlacitko.pocet = batoh.lektvary[zaznam]['pocet']
		
		jmenovka.text = zaznam
		barva.color = batoh.lektvary[zaznam]['barva']
		poradi += 1


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		for poradi:int in range(1,10):
			if event.is_action_released("nabidka_{0}".format([poradi])):
				_vypit_lektvar(poradi)


func _vypit_lektvar(poradi:int) -> void:
	var tlacitko: Node = get_node('%Tlacitko_{0}'.format([poradi]))
	var nazev_lektvaru: String = tlacitko.nazev
	
	if not tlacitko.visible:
		return
	
	vlastnosti.pusobeni(
		batoh.lektvary[nazev_lektvaru].efekt,
		batoh.lektvary[nazev_lektvaru].trvani)
	batoh.zmena(nazev_lektvaru, -1, batoh.lektvary)
