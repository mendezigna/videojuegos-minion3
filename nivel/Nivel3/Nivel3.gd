extends Node2D

onready var player = $Player
export var cantDeClones = 3
onready var plataformaH = $PlatBot/Plataforma
onready var plataformaV1 = $PlatBot2/Plataforma
onready var plataformaV2 = $PlatBot3/Plataforma

func _ready():
	player.setCantLimiteClones(cantDeClones)
	plataformaH.start(0, 0, 0, 140)
	plataformaV1.start(95, 0, 0, 0)
	plataformaV2.start(95, 0, 0, 0)
	
func _on_Boton_apretado():
	plataformaH.derecha(0.5)

func _on_Boton_suelto():
	plataformaH.izquierda(0.5)

func _on_game_over():
	$TimerDead.start()
	player.morir()
	$AudioStreamPlayer2D.stop()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	player.remove_clon(clone)

func _on_BotonV1_apretado():
	plataformaV1.subir(0.5)

func _on_BotonV1_suelto():
	plataformaV1.bajar(0.5)

func _on_BotonV2_apretado():
	plataformaV2.subir(0.5)

func _on_BotonV2_suelto():
	plataformaV2.bajar(0.5)

func _win_game(body):
	if body.is_in_group("player"):
		player.win()
		$AudioStreamPlayer2D.stop()
		$win.play()