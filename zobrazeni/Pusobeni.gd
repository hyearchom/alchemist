extends HBoxContainer

const UCINEK := preload("res://zobrazeni/ucinek.tscn")
const INTERVAL_TRVANI: float = 4.0

@export var vlastnosti: Resource

func _ready() -> void:
	vlastnosti.novy_efekt.connect(zobrazit_ucinek)


func zobrazit_ucinek(efekt: String, trvani: float) -> void:
	var policko: Node = UCINEK.instantiate()
	policko.nazev = efekt
	policko.trvani = trvani *INTERVAL_TRVANI
	add_child(policko)
	move_child(policko, 0)
