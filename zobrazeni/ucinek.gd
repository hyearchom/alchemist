extends PanelContainer

@export var vlastnosti: Resource

var nazev: StringName
var trvani: float


func _ready() -> void:
	$Nazev.text = nazev.left(1).to_upper()
	$Ukonceni.timeout.connect(konec_pusobeni)
	$Ukonceni.start(trvani)


func konec_pusobeni() -> void:
	vlastnosti.ukoncit_efekt(nazev)
	queue_free()
