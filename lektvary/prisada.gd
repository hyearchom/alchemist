extends Area2D

@export var nazev: StringName

func _dotyk(telo:Node2D) -> void:
	if telo.is_in_group('hrac'):
		telo.predmet_ziskan(nazev)
		queue_free()
