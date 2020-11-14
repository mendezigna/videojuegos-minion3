extends Node2D

onready var boss = $Boss
onready var player = $Player
export var cantDeClones = 3
export var test = false
onready var plataforma1 = $plataformas/plataforma1/Plataforma
var yaSePresentoElNivel = false
var aumentandoZoom = false
var disminuyendoZoom = false

func _ready():
	player.setCantLimiteClones(cantDeClones)
	boss.personaje_Position(player.position)
	plataforma1.start(300, 0, 0, 0)
	
	if get_node("/root/Global").test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false
			$Background2/CanvasModulate.visible = false
	
	player.desactivar()
	enfocar_al_boss_y_mostrar_el_nivel()
	


func enfocar_al_boss_y_mostrar_el_nivel():
	$Camera2D.position =  player.position
	$PresentarElNivel/TiempoDePresentacionDelPersonaje.start()
	


func _on_TiempoDePresentacionDelPersonaje_timeout():
	$Camera2D.position =  boss.position
	$PresentarElNivel/TiempoDePresentacionDelBoss.start()


func _on_TiempoDePresentacionDelBoss_timeout():
	mostrar_el_nivel()


func mostrar_el_nivel():
	$Camera2D.limit_smoothed = false
	$Camera2D.smoothing_speed = 0.2
	aumentandoZoom = true
	$Camera2D.position = $Puerta.position
	$PresentarElNivel/TiempoDePresentacionDelNivel.start()
	
	
func aumentar_zoom():
	if (aumentandoZoom && $Camera2D.zoom.x <= 0.8):
		$Camera2D.zoom.x += 0.01
		$Camera2D.zoom.y += 0.01
	else:
		aumentandoZoom = false
	

func disminuirZoom():
	if (disminuyendoZoom && $Camera2D.zoom.x >= 0.45):
		$Camera2D.zoom.x -= 0.01
		$Camera2D.zoom.y -= 0.01
	else:
		disminuyendoZoom = false
	



func _on_TiempoDePresentacionDelNivel_timeout():
	$Camera2D.limit_smoothed = true
	$Camera2D.smoothing_speed = 5
	disminuyendoZoom = true
	yaSePresentoElNivel = true
	player.activar()



# warning-ignore:unused_argument
func _physics_process(delta):
	aumentar_zoom()
	disminuirZoom()
	if yaSePresentoElNivel:
		if player.activo:
			$Camera2D.position =  player.position
		elif player.new_clon != null:
			$Camera2D.position =  player.new_clon.position
		boss.personaje_Position(player.position)



func _on_game_over():
	$TimerDead.start()
	boss.playerMurio()
	player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	player.remove_clon(clone)


func _win_game(body):
	if body.is_in_group("player"):
		player.win()
		$win.play()


func _on_Boton_apretado():
	plataforma1.subir(0.5)

func _on_Boton_suelto():
	plataforma1.bajar(0.5)




