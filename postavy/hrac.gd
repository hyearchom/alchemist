extends CharacterBody2D


const RYCHLOST_POHYBU: float = 400.0
const VYSKA_SKOKU: float = -500.0
const ZAKLADNI_NASOBITEL_TIHY: int = 4
const STUPEN_TIHY: float = 250.0

@export var vlastnosti: Resource
@export var batoh: Resource


func _physics_process(delta: float) -> void:
	if not stoji_na_zemi():
		pusobeni_tihy(delta)

	# Handle jump.
	if Input.is_action_just_pressed("skok") and is_on_floor():
		velocity.y = VYSKA_SKOKU

	# Get the input direction and handle the movement/deceleration.
	var smer := Input.get_axis("doleva", "doprava")
	if smer:
		velocity.x = smer * RYCHLOST_POHYBU
	else:
		velocity.x = move_toward(velocity.x, 0, RYCHLOST_POHYBU)

	move_and_slide()


func pusobeni_tihy(delta:float) -> Vector2:
	var nasobitel_tihy := vypocist_nasobitel_tihy()

	velocity.y += nasobitel_tihy *STUPEN_TIHY *delta
	return velocity


func vypocist_nasobitel_tihy() -> int:
	var nasobitel: int
	
	nasobitel = ZAKLADNI_NASOBITEL_TIHY 
	if vlastnosti.status.has('tiha'):
		nasobitel += vlastnosti.status.tiha
	return nasobitel


func stoji_na_zemi() -> bool:
	var nasobitel := vypocist_nasobitel_tihy()
	if nasobitel >= 0:
		return is_on_floor()
	else:
		return is_on_ceiling()
	

func predmet_ziskan(nazev:StringName, pocet:int=1, 
		kontejner:Dictionary=batoh.prisady) -> void:
	batoh.zmena(nazev, pocet, kontejner)
